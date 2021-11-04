USE SCHEMA %ENV%_DDEX_DSR.PUBLIC;

create or replace procedure %ENV%_DDEX_DSR.PUBLIC.ingest_asset_sp(ASSET_JSON VARCHAR)
  returns VARCHAR not null
  language javascript
  EXECUTE AS CALLER
  as
  $$
try {
    var setDB = snowflake.execute({sqlText: `use database %ENV%_DDEX_DSR`});

    // Upsert Door.Asset Table
    var assetId;
    snowflake.execute({sqlText: "BEGIN"});
    try {
        var upsertAsset = snowflake.execute({
            sqlText: 'CALL %ENV%_DOOR.PUBLIC.UPSERT_ASSET_SP(parse_json(:1))',
            binds: [ASSET_JSON]
        });
        upsertAsset.next()
        assetId = upsertAsset.getColumnValue(1);
        snowflake.execute({sqlText: "COMMIT"});
    } catch (e) {
        snowflake.execute({sqlText: "ROLLBACK"});
        throw e;
    }
    var setDB = snowflake.execute({sqlText: `use database %ENV%_DDEX_DSR`});


    // Lookup Ingestion Config
    var ingestConfig = snowflake.execute({sqlText: `
SELECT ic.schema, ic.function, a.reference_copy_key
FROM %ENV%_DDEX_DSR.STAGING.INGEST_CONFIG ic, %ENV%_DOOR.PUBLIC.ASSET a
WHERE ic.source = a.source
AND ic.schema_version = a.schema_version
AND a.id = '${assetId}'`});

    var ingestConfigCount = ingestConfig.getRowCount();
    if (ingestConfigCount == 0) {
        return JSON.stringify({
            state: 'ERROR',
            messages: [{
                type: 'INGEST_CONFIG_NOT_FOUND',
                message: 'No Ingest Config found for DDEX DSR FlatFile Asset',
            }]
        });
    } else if (ingestConfigCount > 1) {
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

    // Create Tmp Tables for Staging File
    const rand = Math.floor(Math.random() * 4294967296);
    var flatFileTable = `%ENV%_DDEX_DSR.STAGING.FLAT_FILE_${rand}`;
    var delimitedFileTable = `%ENV%_DDEX_DSR.STAGING.DELIMITED_FILE_${rand}`;

    snowflake.execute( {sqlText: `
    CREATE OR REPLACE TEMPORARY TABLE ${flatFileTable} (
        ASSET_ID VARCHAR,
        LINE_INDEX INTEGER,
        LINE VARCHAR
    )`});
    snowflake.execute( {sqlText: `
    CREATE OR REPLACE TEMPORARY TABLE ${delimitedFileTable} (
        ASSET_ID VARCHAR,
        LINE_INDEX INTEGER,
        FIELDS ARRAY
    )`});

    // Ingest Asset into Staging Tables
    var copyIntoStage = snowflake.execute({sqlText: `
COPY INTO ${flatFileTable} from (
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
from ${flatFileTable}`});

    // Upsert data into Untyped Record Schema as Transaction
    snowflake.execute({sqlText: "BEGIN"});
    try {
        var DEL_ASSETS_SP_RESULT = snowflake.execute({sqlText: `call %ENV%_DDEX_DSR.${ingestSchema}.delete_assets(array_construct('${assetId}'))`});
        var INSERT_ASSETS_SP_RESULT = snowflake.execute({sqlText: `call %ENV%_DDEX_DSR.${ingestSchema}.insert_assets('${delimitedFileTable}', array_construct('${assetId}'))`});
        snowflake.execute({sqlText: "COMMIT"});
    } catch (e) {
    snowflake.execute({sqlText: "ROLLBACK"});
    throw e;
    }

    // Upsert data into Violation Schema as Transaction
    var validationSchema = 'VALIDATION'+ingestSchema.substring(7);
    var violationTable = `%ENV%_DDEX_DSR.${validationSchema}.VIOLATION`;
    var violationTmpTable = `%ENV%_DDEX_DSR.${validationSchema}.VIOLATION_TMP_${rand}`;
    snowflake.execute({sqlText: `create temporary table ${violationTmpTable} LIKE ${violationTable}`});
    snowflake.execute({sqlText: `call %ENV%_DDEX_DSR.${validationSchema}.insert_violations('${violationTmpTable}', array_construct('${assetId}'))`});
    snowflake.execute({sqlText: "BEGIN"});
    try {
        var deleteViolations = snowflake.execute({sqlText: `DELETE FROM ${violationTable} WHERE ASSET_ID IN ('${assetId}')`});
        var insertViolations = snowflake.execute({sqlText: `INSERT INTO ${violationTable} (ASSET_ID,ASSET_PART,VIOLATION,VIOLATION_DETAIL) SELECT ASSET_ID,ASSET_PART,VIOLATION,VIOLATION_DETAIL from ${violationTmpTable}`});
        var commit = snowflake.execute({sqlText: "COMMIT"});
    } catch (e) {
        snowflake.execute({sqlText: "ROLLBACK"});
        throw e;
    }

    try {
        var dropFlatable = snowflake.execute({sqlText: `drop table ${flatFileTable}`});
        var dropDelimitedTable = snowflake.execute({sqlText: `drop table ${delimitedFileTable}`});
    } catch (err) {
    }
    return JSON.stringify({
        state: 'COMPLETED'
    });
} catch (err) {
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