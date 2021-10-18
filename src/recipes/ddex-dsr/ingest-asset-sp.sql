USE SCHEMA %ENV%_DDEX_DSR.PUBLIC;

create or replace procedure ingest_asset_sp(ASSET_JSON VARCHAR)
  returns VARCHAR not null
  language javascript
  EXECUTE AS CALLER
  as
  $$
try {
    var setDB = snowflake.execute({sqlText: `use database %ENV%_DDEX_DSR`});

    var uuidResult = snowflake.execute({sqlText: "select replace(UUID_STRING(), '-', '')"});
    uuidResult.next();
    var uuid = uuidResult.getColumnValue(1);
    var delimitedFileTable = `STAGING.DELIMITED_FILE_${uuid}`

    var createTempTable = snowflake.execute( {sqlText: `
    CREATE OR REPLACE TEMPORARY TABLE ${delimitedFileTable} (
        ASSET_ID VARCHAR,
        LINE_INDEX INTEGER,
        FIELDS ARRAY
    )`});


    var begin = snowflake.execute({sqlText: "BEGIN"});

    var upsertAsset = snowflake.execute({
        sqlText: 'CALL %ENV%_DOOR.PUBLIC.UPSERT_ASSET_SP(parse_json(:1))',
        binds: [ASSET_JSON]
    });
    upsertAsset.next()
    var assetId = upsertAsset.getColumnValue(1);

    var setDB = snowflake.execute({sqlText: `use database %ENV%_DDEX_DSR`});

    // Lookup Ingestion Config
    var ingestConfig = snowflake.execute({sqlText: `
SELECT ic.schema, ic.function, a.reference_copy_key
FROM STAGING.INGEST_CONFIG ic, %ENV%_DOOR.PUBLIC.ASSET a
WHERE ic.source = a.source
AND ic.schema_version = a.schema_version
AND a.id = '${assetId}'`});

    var ingestConfigCount = ingestConfig.getRowCount();
    if (ingestConfigCount == 0) {
        var rollback = snowflake.execute({sqlText: "ROLLBACK"});
        return JSON.stringify({
            state: 'ERROR',
            messages: [{
                type: 'INGEST_CONFIG_NOT_FOUND',
                message: 'No Ingest Config found for DDEX DSR FlatFile Asset',
            }]
        });
    } else if (ingestConfigCount > 1) {
        var rollback = snowflake.execute({sqlText: "ROLLBACK"});
        return JSON.stringify({
            state: 'ERROR',
            messages: [{
                type: 'MULTIPLE_INGEST_CONFIG_FOUND',
                message: 'Multiple Ingest Configs found for DDEX DSR FlatFile Asset',
            }]
        });
    }
    ingestConfig.next();
    var ingestSchema = ingestConfig.getColumnValue(1);
    var ingestFunction = ingestConfig.getColumnValue(2);
    var referenceCopyKey = ingestConfig.getColumnValue(3);

    var deleteStage = snowflake.execute({sqlText: `DELETE FROM STAGING.FLAT_FILE WHERE ASSET_ID = '${assetId}'`});
    var copyIntoStage = snowflake.execute({sqlText: `
COPY INTO STAGING.FLAT_FILE from (
    SELECT '${assetId}', METADATA$FILE_ROW_NUMBER, t.$1
    FROM @%ENV%_RAW.PUBLIC.DOOR_REFERENCE_STAGE t)
FILES = ('${referenceCopyKey}')
FILE_FORMAT = 'STAGING.FLAT_FILE_UTF8'
FORCE=true;`});

    var delimitedFile = snowflake.execute({sqlText: `
insert into ${delimitedFileTable} (
    ASSET_ID, LINE_INDEX, FIELDS
)
select ASSET_ID, LINE_INDEX, ${ingestFunction}(line)
from STAGING.FLAT_FILE
where ASSET_ID = '${assetId}'`});

    var DEL_ASSETS_SP_RESULT = snowflake.execute({sqlText: `call ${ingestSchema}.delete_assets(array_construct('${assetId}'))`});
    var INSERT_ASSETS_SP_RESULT = snowflake.execute({sqlText: `call ${ingestSchema}.insert_assets('${delimitedFileTable}', array_construct('${assetId}'))`});

    // **** Validation Prototyping *****
    var validationSchema = 'VALIDATION'+ingestSchema.substring(7);
    var blockRecordTypeRegex = "'(RE|AS|LC|MW|CU|RC|SU|RU|LI|ST|ML|SR)\\d{2}(.\\d{2})?'";

    var deleteRecordStructure = snowflake.execute({sqlText: `DELETE FROM ${validationSchema}.RECORD_STRUCTURE WHERE ASSET_ID = '${assetId}'`});
    var deleteBlockBoundary = snowflake.execute({sqlText: `DELETE FROM ${validationSchema}.BLOCK_BOUNDARY WHERE ASSET_ID  = '${assetId}'`});

    var insertRecordStructure = snowflake.execute({sqlText: `
INSERT INTO ${validationSchema}.RECORD_STRUCTURE (
    ASSET_ID,
    LINE_INDEX,
    RECORD_TYPE,
    BLOCK_ID
) SELECT
    ASSET_ID,
    LINE_INDEX,
    FIELDS[0][0]::STRING,
    IFF(FIELDS[0][0]::STRING REGEXP ${blockRecordTypeRegex}, FIELDS[1][0]::STRING, null)
from ${delimitedFileTable} where ASSET_ID = '${assetId}'`});

    var insertBlockBoundary = snowflake.execute({sqlText: `
INSERT INTO ${validationSchema}.BLOCK_BOUNDARY (
    ASSET_ID,
    BLOCK_ID,
    START_INDEX,
    END_INDEX
)
select ASSET_ID, FIELDS[1][0]::STRING block_id, min(line_index) start_line_index, max(line_index) end_line_index
from ${delimitedFileTable}
where FIELDS[0][0]::STRING REGEXP ${blockRecordTypeRegex}
and ASSET_ID = '${assetId}'
group by ASSET_ID, FIELDS[1][0]::STRING`});

    var deleteViolations = snowflake.execute({sqlText: `call ${validationSchema}.delete_violations(array_construct('${assetId}'))`});
    var insertViolations = snowflake.execute({sqlText: `call ${validationSchema}.insert_violations(array_construct('${assetId}'))`});

    // **** Validation Prototyping *****

    var commit = snowflake.execute({sqlText: "COMMIT"});

    try {
        var dropDelimitedTable = snowflake.execute({sqlText: `drop table ${delimitedFileTable}`});
    } catch (err) {
    }
    return JSON.stringify({
        state: 'COMPLETED'
    });
} catch (err) {
    var log = snowflake.createStatement( {sqlText: `select 'Entered Catch ${err}'`} ).execute();
    var rollback = snowflake.execute({sqlText: "ROLLBACK"});
    return JSON.stringify({
        state: 'ERROR',
        messages: [{
            type: 'UNEXPECTED_ERROR',
            message: 'Unexpected Error during DDEX DSR FlatFile Asset Ingestion',
            args: [{
                key: 'ERROR_MSG',
                value: err
            }]
        }]
    });
}
  $$;