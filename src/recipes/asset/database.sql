use role sysadmin;

-- NOTE: We may want to consider renaming this DB since it is now just containing the Door Asset Information
-- So maybe <ENV>_DOOR going forward and putting the table into the PUBLIC SCHEMA?
create or replace database %ENV%_DOOR;

use database %ENV%_DOOR;

create or replace schema PUBLIC;

use schema PUBLIC;

CREATE OR REPLACE TABLE ASSET(
  ID VARCHAR,
  REFERENCE_COPY_KEY VARCHAR,
  FILE_FORMAT VARCHAR,
  FILE_TYPE VARCHAR,
  SCHEMA_VERSION VARCHAR,
  ORIGINAL_FILENAME VARCHAR,
  SIZE integer,
  SOURCE VARCHAR,
  TAGS OBJECT
);

use schema %ENV%_DOOR.PUBLIC;

create or replace procedure upsert_asset_sp(ASSET_JSON VARIANT)
  returns VARCHAR NOT NULL
  language javascript
  EXECUTE AS CALLER
  as
  $$
    var tags = 'OBJECT_CONSTRUCT_KEEP_NULL(' + ASSET_JSON.tags.map(t => {
        var idx = t.indexOf(':');
        if (idx >= 0) {
            var key = t.substr(0, idx);
            var value = t.substr(idx+1);
            return `'${key}','${value}'`;
        } else {
            return `'${t}',NULL`;
        }
    }).join(",") + ')';

    var deleteAsset = snowflake.execute({sqlText: `
DELETE FROM %ENV%_DOOR.PUBLIC.ASSET WHERE ID = '${ASSET_JSON.assetId}'`});
    var insertAsset = snowflake.execute({sqlText: `
INSERT INTO %ENV%_DOOR.PUBLIC.ASSET (ID, REFERENCE_COPY_KEY, FILE_FORMAT, FILE_TYPE, SCHEMA_VERSION, ORIGINAL_FILENAME, SIZE, SOURCE, TAGS)
SELECT '${ASSET_JSON.assetId}', '${ASSET_JSON.referenceCopyId.split('/').pop()}', '${ASSET_JSON.fileFormat}', '${ASSET_JSON.fileType}', '${ASSET_JSON.schemaVersion}', '${ASSET_JSON.originalFileName}', ${ASSET_JSON.size}, '${ASSET_JSON.sourceId}', ${tags}`});

    return ASSET_JSON.assetId;
  $$
;