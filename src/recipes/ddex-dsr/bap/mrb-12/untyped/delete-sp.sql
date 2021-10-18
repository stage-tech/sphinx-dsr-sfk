create or replace procedure delete_assets(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";

var HEAD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.HEAD WHERE ASSET_ID in (${assets})`});
var FOOT = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.FOOT WHERE ASSET_ID in (${assets})`});
var SY01_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY01_01 WHERE ASSET_ID in (${assets})`});
var SY02_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY02_02 WHERE ASSET_ID in (${assets})`});
var SY04_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY04_01 WHERE ASSET_ID in (${assets})`});
var SY05_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY05_02 WHERE ASSET_ID in (${assets})`});
var RE01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.RE01 WHERE ASSET_ID in (${assets})`});
var RE02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.RE02 WHERE ASSET_ID in (${assets})`});
var AS01_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.AS01_01 WHERE ASSET_ID in (${assets})`});
var AS02_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.AS02_02 WHERE ASSET_ID in (${assets})`});
var MW01_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.MW01_01 WHERE ASSET_ID in (${assets})`});
var SU01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SU01 WHERE ASSET_ID in (${assets})`});
var SU02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SU02 WHERE ASSET_ID in (${assets})`});
var UNEXPECTED_RECORD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.UNEXPECTED_RECORD WHERE ASSET_ID in (${assets})`});
  $$
  ;

