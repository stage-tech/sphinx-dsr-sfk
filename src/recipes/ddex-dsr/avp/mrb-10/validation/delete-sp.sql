create or replace procedure delete_violations(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as
  $$

var assets = "'" + ASSET_IDS.join("','") + "'";
var useSchema = snowflake.execute({sqlText: 'use schema %ENV%_DDEX_DSR.VALIDATION_AVP_MRB_10'});
var deleteViolations = snowflake.execute({sqlText: `DELETE FROM VIOLATION WHERE ASSET_ID IN (${assets})`});

  $$
;