create or replace procedure insert_assets(STAGING_TABLE VARCHAR, ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";


var HEAD = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.HEAD (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  MESSAGE_VERSION,
  PROFILE,
  PROFILE_VERSION,
  MESSAGE_ID,
  MESSAGE_CREATED_DATE_TIME,
  FILE_NUMBER,
  NUMBER_OF_FILES,
  USAGE_START_DATE,
  USAGE_END_DATE,
  SENDER_PARTY_ID,
  SENDER_NAME,
  SERVICE_DESCRIPTION,
  RECIPIENT_PARTY_ID,
  RECIPIENT_NAME,
  REPRESENTED_REPERTOIRE,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  FIELDS[15]::array,
  ARRAY_SLICE(FIELDS, 16, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'HEAD'
and ASSET_ID in (${assets})`});


var FOOT = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.FOOT (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  NUMBER_OF_LINES_IN_FILE,
  NUMBER_OF_LINES_IN_REPORT,
  NUMBER_OF_SUMMARY_RECORDS,
  NUMBER_OF_BLOCKS_IN_FILE,
  NUMBER_OF_BLOCKS_IN_REPORT,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  ARRAY_SLICE(FIELDS, 6, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'FOOT'
and ASSET_ID in (${assets})`});


var SY01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  SUMMARY_RECORD_ID,
  DISTRIBUTION_CHANNEL,
  DISTRIBUTION_CHANNEL_DPID,
  COMMERCIAL_MODEL,
  USE_TYPE,
  TERRITORY,
  SERVICE_DESCRIPTION,
  USAGES,
  SUBSCRIBERS,
  CURRENCY_OF_REPORTING,
  NET_REVENUE,
  INDIRECT_NET_REVENUE,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  ARRAY_SLICE(FIELDS, 13, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SY01'
and ASSET_ID in (${assets})`});


var SY02_01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY02_01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  SUMMARY_RECORD_ID,
  DISTRIBUTION_CHANNEL,
  DISTRIBUTION_CHANNEL_DPID,
  COMMERCIAL_MODEL,
  USE_TYPE,
  TERRITORY,
  SERVICE_DESCRIPTION,
  USAGES,
  USERS,
  CURRENCY_OF_REPORTING,
  NET_REVENUE,
  RIGHTS_CONTROLLER,
  RIGHTS_CONTROLLER_PARTY_ID,
  ALLOCATED_USAGES,
  ALLOCATED_REVENUE,
  ALLOCATED_NET_REVENUE,
  RIGHTS_TYPE,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  FIELDS[15]::array,
  FIELDS[16]::array,
  FIELDS[17]::array,
  ARRAY_SLICE(FIELDS, 18, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SY02.01'
and ASSET_ID in (${assets})`});


var SY04 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY04 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  SUMMARY_RECORD_ID,
  DISTRIBUTION_CHANNEL,
  DISTRIBUTION_CHANNEL_DPID,
  COMMERCIAL_MODEL,
  USE_TYPE,
  TERRITORY,
  SERVICE_DESCRIPTION,
  SUBSCRIBER_TYPE,
  SUBSCRIBERS,
  SUB_PERIOD_START_DATE,
  SUB_PERIOD_END_DATE,
  USAGES_IN_SUB_PERIOD,
  USAGES_IN_REPORTING_PERIOD,
  CURRENCY_OF_REPORTING,
  CURRENCY_OF_TRANSACTION,
  EXCHANGE_RATE,
  CONSUMER_PAID_UNIT_PRICE,
  NET_REVENUE,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  FIELDS[15]::array,
  FIELDS[16]::array,
  FIELDS[17]::array,
  FIELDS[18]::array,
  ARRAY_SLICE(FIELDS, 19, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SY04'
and ASSET_ID in (${assets})`});


var SY05 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SY05 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  SUMMARY_RECORD_ID,
  DISTRIBUTION_CHANNEL,
  DISTRIBUTION_CHANNEL_DPID,
  COMMERCIAL_MODEL,
  USE_TYPE,
  TERRITORY,
  SERVICE_DESCRIPTION,
  RIGHTS_CONTROLLER,
  RIGHTS_CONTROLLER_PARTY_ID,
  RIGHTS_TYPE,
  TOTAL_USAGES,
  ALLOCATED_USAGES,
  MUSIC_USAGE_RATIO,
  ALLOCATED_NET_REVENUE,
  ALLOCATED_REVENUE,
  RIGHTS_CONTROLLER_MARKET_SHARE,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  FIELDS[15]::array,
  FIELDS[16]::array,
  ARRAY_SLICE(FIELDS, 17, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SY05'
and ASSET_ID in (${assets})`});


var RE01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.RE01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RELEASE_REFERENCE,
  DSP_RELEASE_ID,
  PROPRIETARY_RELEASE_ID,
  CATALOG_NUMBER,
  ICPN,
  DISPLAY_ARTIST_NAME,
  DISPLAY_ARTIST_PARTY_ID,
  TITLE,
  SUB_TITLE,
  RELEASE_TYPE,
  LABEL,
  P_LINE,
  DATA_PROVIDER,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  ARRAY_SLICE(FIELDS, 15, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'RE01'
and ASSET_ID in (${assets})`});


var RE02 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.RE02 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RELEASE_REFERENCE,
  DSP_SUB_RELEASE_ID,
  PROPRIETARY_SUB_RELEASE_ID,
  USED_RESOURCES,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  ARRAY_SLICE(FIELDS, 6, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'RE02'
and ASSET_ID in (${assets})`});


var AS01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.AS01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RESOURCE_REFERENCE,
  DSP_RESOURCE_ID,
  ISRC,
  TITLE,
  SUB_TITLE,
  DISPLAY_ARTIST_NAME,
  DISPLAY_ARTIST_PARTY_ID,
  DURATION,
  RESOURCE_TYPE,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  ARRAY_SLICE(FIELDS, 11, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'AS01'
and ASSET_ID in (${assets})`});


var AS02_01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.AS02_01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RESOURCE_REFERENCE,
  DSP_RESOURCE_ID,
  ISRC,
  TITLE,
  SUB_TITLE,
  DISPLAY_ARTIST_NAME,
  DISPLAY_ARTIST_PARTY_ID,
  DURATION,
  RESOURCE_TYPE,
  ISWC,
  COMPOSER_AUTHOR,
  COMPOSER_AUTHOR_PARTY_ID,
  ARRANGER,
  ARRANGER_PARTY_ID,
  MUSIC_PUBLISHER,
  MUSIC_PUBLISHER_PARTY_ID,
  WORK_CONTRIBUTOR,
  WORK_CONTRIBUTOR_PARTY_ID,
  PROPRIETARY_WORK_ID,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  FIELDS[15]::array,
  FIELDS[16]::array,
  FIELDS[17]::array,
  FIELDS[18]::array,
  FIELDS[19]::array,
  FIELDS[20]::array,
  ARRAY_SLICE(FIELDS, 21, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'AS02.01'
and ASSET_ID in (${assets})`});


var MW01_01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.MW01_01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  DSP_WORK_ID,
  ISWC,
  TITLE,
  SUB_TITLE,
  COMPOSER_AUTHOR,
  COMPOSER_AUTHOR_PARTY_ID,
  ARRANGER,
  ARRANGER_PARTY_ID,
  MUSIC_PUBLISHER,
  MUSIC_PUBLISHER_PARTY_ID,
  WORK_CONTRIBUTOR,
  WORK_CONTRIBUTOR_PARTY_ID,
  DATA_PROVIDER,
  PROPRIETARY_WORK_ID,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  FIELDS[12]::array,
  FIELDS[13]::array,
  FIELDS[14]::array,
  FIELDS[15]::array,
  ARRAY_SLICE(FIELDS, 16, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'MW01.01'
and ASSET_ID in (${assets})`});


var SU01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SU01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  SUMMARY_RECORD_ID,
  SALES_TRANSACTION_ID,
  TRANSACTED_RELEASE,
  TRANSACTED_RESOURCE,
  IS_ROYALTY_BEARING,
  SALES_UPGRADE,
  USAGES,
  RETURNS,
  PRICE_CONSUMER_PAID_EXC_SALES_TAX,
  PROMOTIONAL_ACTIVITY,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  FIELDS[10]::array,
  FIELDS[11]::array,
  ARRAY_SLICE(FIELDS, 12, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SU01'
and ASSET_ID in (${assets})`});


var SU02 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.SU02 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  SUMMARY_RECORD_ID,
  SALES_TRANSACTION_ID,
  TRANSACTED_RELEASE,
  TRANSACTED_RESOURCE,
  IS_ROYALTY_BEARING,
  NUMBER_OF_STREAMS,
  PRICE_CONSUMER_PAID_EXC_SALES_TAX,
  PROMOTIONAL_ACTIVITY,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS[0]::array,
  FIELDS[1]::array,
  FIELDS[2]::array,
  FIELDS[3]::array,
  FIELDS[4]::array,
  FIELDS[5]::array,
  FIELDS[6]::array,
  FIELDS[7]::array,
  FIELDS[8]::array,
  FIELDS[9]::array,
  ARRAY_SLICE(FIELDS, 10, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SU02'
and ASSET_ID in (${assets})`});


var UNEXPECTED_RECORD = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_11.UNEXPECTED_RECORD (
  ASSET_ID,
  LINE_INDEX,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS
from ${STAGING_TABLE} DF
where FIELDS[0][0] not in ('HEAD','FOOT','SY01','SY02.01','SY04','SY05','RE01','RE02','AS01','AS02.01','MW01.01','SU01','SU02') 
and SUBSTR(FIELDS[0][0], 1, 1) != '#'
and ASSET_ID in (${assets})`});


  $$
  ;
