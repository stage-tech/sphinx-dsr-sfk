create or replace procedure delete_assets(ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";

var HEAD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.HEAD WHERE ASSET_ID in (${assets})`});
var FOOT = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.FOOT WHERE ASSET_ID in (${assets})`});
var SY01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY01 WHERE ASSET_ID in (${assets})`});
var SY02_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY02_01 WHERE ASSET_ID in (${assets})`});
var SY04 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY04 WHERE ASSET_ID in (${assets})`});
var SY05 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY05 WHERE ASSET_ID in (${assets})`});
var RE01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.RE01 WHERE ASSET_ID in (${assets})`});
var RE02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.RE02 WHERE ASSET_ID in (${assets})`});
var AS01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.AS01 WHERE ASSET_ID in (${assets})`});
var AS02_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.AS02_01 WHERE ASSET_ID in (${assets})`});
var MW01_01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.MW01_01 WHERE ASSET_ID in (${assets})`});
var SU01 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SU01 WHERE ASSET_ID in (${assets})`});
var SU02 = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SU02 WHERE ASSET_ID in (${assets})`});
var UNEXPECTED_RECORD = snowflake.execute({sqlText: `DELETE FROM %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.UNEXPECTED_RECORD WHERE ASSET_ID in (${assets})`});
  $$
  ;

