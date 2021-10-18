create or replace procedure insert_assets(STAGING_TABLE VARCHAR, ASSET_IDS ARRAY)
  returns boolean
  language javascript
  EXECUTE AS CALLER
  as     
  $$
  
var assets = "'" + ASSET_IDS.join("','") + "'";


var HEAD = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.HEAD (
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


var FOOT = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.FOOT (
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


var SY04_01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.SY04_01 (
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
  MUSIC_USAGE_PERCENTAGE,
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
  ARRAY_SLICE(FIELDS, 20, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SY04.01'
and ASSET_ID in (${assets})`});


var RE03 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.RE03 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RELEASE_REFERENCE,
  DSP_RELEASE_ID,
  PROPRIETARY_RELEASE_ID,
  ICPN,
  TITLE,
  SUB_TITLE,
  SERIES_TITLE,
  SEASON_NUMBER,
  DISPLAY_ARTIST_NAME,
  DISPLAY_ARTIST_PARTY_ID,
  RELEASE_TYPE,
  DATA_PROVIDER_NAME,
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
  ARRAY_SLICE(FIELDS, 14, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'RE03'
and ASSET_ID in (${assets})`});


var AS03 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.AS03 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RESOURCE_REFERENCE,
  DSP_RESOURCE_ID,
  ISAN,
  EIDR,
  PROPRIETARY_ID,
  VIDEO_TYPE,
  TITLE,
  SUB_TITLE,
  ORIGINAL_TITLE,
  SEASON_NUMBER,
  EPISODE_NUMBER,
  GENRE,
  DURATION,
  PRODUCER_NAME,
  PRODUCER_PARTY_ID,
  DIRECTOR_NAME,
  DIRECTOR_PARTY_ID,
  ACTOR_NAME,
  ACTOR_PARTY_ID,
  LANGUAGE_LOCALIZATION_TYPE,
  HAS_CAPTIONING,
  HAS_AUDIO_DESCRIPTION,
  LANGUAGE_OF_PERFORMANCE,
  LANGUAGE_OF_DUBBING,
  PRODUCTION_OR_RELEASE_DATE,
  COUNTRY_OF_PRODUCTION,
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
  FIELDS[21]::array,
  FIELDS[22]::array,
  FIELDS[23]::array,
  FIELDS[24]::array,
  FIELDS[25]::array,
  FIELDS[26]::array,
  FIELDS[27]::array,
  ARRAY_SLICE(FIELDS, 28, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'AS03'
and ASSET_ID in (${assets})`});


var SU03_01 = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.SU03_01 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  SALES_TRANSACTION_ID,
  SUMMARY_RECORD_ID,
  DSP_RESOURCE_ID,
  USAGES,
  NET_REVENUE,
  VALIDITY_PERIOD_START,
  VALIDITY_PERIOD_END,
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
  ARRAY_SLICE(FIELDS, 9, ARRAY_SIZE(FIELDS))
from ${STAGING_TABLE} DF
where FIELDS[0][0] = 'SU03.01'
and ASSET_ID in (${assets})`});


var UNEXPECTED_RECORD = snowflake.execute({sqlText: `INSERT INTO %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.UNEXPECTED_RECORD (
  ASSET_ID,
  LINE_INDEX,
  UNEXPECTED_DATA)
SELECT
  ASSET_ID,
  LINE_INDEX,
  FIELDS
from ${STAGING_TABLE} DF
where FIELDS[0][0] not in ('HEAD','FOOT','SY04.01','RE03','AS03','SU03.01') 
and SUBSTR(FIELDS[0][0], 1, 1) != '#'
and ASSET_ID in (${assets})`});


  $$
  ;
