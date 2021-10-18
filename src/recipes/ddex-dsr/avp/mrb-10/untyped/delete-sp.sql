create or replace procedure delete_assets(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";

var HEAD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.HEAD WHERE ASSET_ID in (${assets})`});
var FOOT = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.FOOT WHERE ASSET_ID in (${assets})`});
var SY04_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.SY04_01 WHERE ASSET_ID in (${assets})`});
var RE03 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.RE03 WHERE ASSET_ID in (${assets})`});
var AS03 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.AS03 WHERE ASSET_ID in (${assets})`});
var SU03_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.SU03_01 WHERE ASSET_ID in (${assets})`});
var UNEXPECTED_RECORD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.UNEXPECTED_RECORD WHERE ASSET_ID in (${assets})`});
  $$
  ;

