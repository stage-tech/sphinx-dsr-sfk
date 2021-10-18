create or replace procedure delete_assets(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";

var HEAD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.HEAD WHERE ASSET_ID in (${assets})`});
var FOOT = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.FOOT WHERE ASSET_ID in (${assets})`});
var SY01_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SY01_02 WHERE ASSET_ID in (${assets})`});
var SY02_03 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SY02_03 WHERE ASSET_ID in (${assets})`});
var SY03_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SY03_01 WHERE ASSET_ID in (${assets})`});
var SY04_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SY04_02 WHERE ASSET_ID in (${assets})`});
var SY05_03 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SY05_03 WHERE ASSET_ID in (${assets})`});
var SY12 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SY12 WHERE ASSET_ID in (${assets})`});
var RE01_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.RE01_02 WHERE ASSET_ID in (${assets})`});
var RE02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.RE02 WHERE ASSET_ID in (${assets})`});
var AS01_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.AS01_02 WHERE ASSET_ID in (${assets})`});
var AS02_03 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.AS02_03 WHERE ASSET_ID in (${assets})`});
var MW01_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.MW01_02 WHERE ASSET_ID in (${assets})`});
var SU01_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SU01_02 WHERE ASSET_ID in (${assets})`});
var SU02_02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.SU02_02 WHERE ASSET_ID in (${assets})`});
var UNEXPECTED_RECORD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_13.UNEXPECTED_RECORD WHERE ASSET_ID in (${assets})`});
  $$
  ;

