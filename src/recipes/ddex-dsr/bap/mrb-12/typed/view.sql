use schema TYPED_BAP_MRB_12;

CREATE OR REPLACE VIEW HEAD (
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
  REPRESENTED_REPERTOIRE
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  MESSAGE_VERSION[0]::string,
  PROFILE[0]::string,
  PROFILE_VERSION[0]::string,
  MESSAGE_ID[0]::string,
  TRY_TO_TIMESTAMP(MESSAGE_CREATED_DATE_TIME[0]::string, 'YYYY-MM-DDTHH24:MI:SSZ'),
  try_to_number(FILE_NUMBER[0]::string),
  try_to_number(NUMBER_OF_FILES[0]::string),
  COALESCE(TRY_TO_DATE(USAGE_START_DATE[0]::string, 'YYYY-MM-DD'),TRY_TO_DATE(USAGE_START_DATE[0]::string, 'YYYY-MM'),TRY_TO_DATE(USAGE_START_DATE[0]::string, 'YYYY')),
  COALESCE(TRY_TO_DATE(USAGE_END_DATE[0]::string, 'YYYY-MM-DD'),TRY_TO_DATE(USAGE_END_DATE[0]::string, 'YYYY-MM'),TRY_TO_DATE(USAGE_END_DATE[0]::string, 'YYYY')),
  SENDER_PARTY_ID[0]::string,
  SENDER_NAME[0]::string,
  IFF(trim(SERVICE_DESCRIPTION[0]::string)='',NULL,SERVICE_DESCRIPTION[0]::string),
  IFF(trim(RECIPIENT_PARTY_ID[0]::string)='',NULL,RECIPIENT_PARTY_ID[0]::string),
  IFF(trim(RECIPIENT_NAME[0]::string)='',NULL,RECIPIENT_NAME[0]::string),
  REPRESENTED_REPERTOIRE
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.HEAD;


CREATE OR REPLACE VIEW FOOT (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  NUMBER_OF_LINES_IN_FILE,
  NUMBER_OF_LINES_IN_REPORT,
  NUMBER_OF_SUMMARY_RECORDS,
  NUMBER_OF_BLOCKS_IN_FILE,
  NUMBER_OF_BLOCKS_IN_REPORT
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  try_to_number(NUMBER_OF_LINES_IN_FILE[0]::string),
  try_to_number(NUMBER_OF_LINES_IN_REPORT[0]::string),
  try_to_number(NUMBER_OF_SUMMARY_RECORDS[0]::string),
  try_to_number(NUMBER_OF_BLOCKS_IN_FILE[0]::string),
  try_to_number(NUMBER_OF_BLOCKS_IN_REPORT[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.FOOT;


CREATE OR REPLACE VIEW SY01_01 (
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
  CURRENCY_OF_TRANSACTION,
  EXCHANGE_RATE
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  SUMMARY_RECORD_ID[0]::string,
  IFF(trim(DISTRIBUTION_CHANNEL[0]::string)='',NULL,DISTRIBUTION_CHANNEL[0]::string),
  IFF(trim(DISTRIBUTION_CHANNEL_DPID[0]::string)='',NULL,DISTRIBUTION_CHANNEL_DPID[0]::string),
  COMMERCIAL_MODEL[0]::string,
  USE_TYPE[0]::string,
  TERRITORY[0]::string,
  IFF(trim(SERVICE_DESCRIPTION[0]::string)='',NULL,SERVICE_DESCRIPTION[0]::string),
  try_to_number(USAGES[0]::string),
  try_to_number(SUBSCRIBERS[0]::string, 38, 8),
  CURRENCY_OF_REPORTING[0]::string,
  try_to_number(NET_REVENUE[0]::string, 38, 8),
  try_to_number(INDIRECT_NET_REVENUE[0]::string, 38, 8),
  IFF(trim(CURRENCY_OF_TRANSACTION[0]::string)='',NULL,CURRENCY_OF_TRANSACTION[0]::string),
  try_to_number(EXCHANGE_RATE[0]::string, 38, 8)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY01_01;


CREATE OR REPLACE VIEW SY02_02 (
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
  CONTENT_CATEGORY,
  CURRENCY_OF_TRANSACTION,
  EXCHANGE_RATE,
  RIGHTS_TYPE_PERCENTAGE
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  SUMMARY_RECORD_ID[0]::string,
  IFF(trim(DISTRIBUTION_CHANNEL[0]::string)='',NULL,DISTRIBUTION_CHANNEL[0]::string),
  IFF(trim(DISTRIBUTION_CHANNEL_DPID[0]::string)='',NULL,DISTRIBUTION_CHANNEL_DPID[0]::string),
  COMMERCIAL_MODEL[0]::string,
  USE_TYPE[0]::string,
  TERRITORY[0]::string,
  SERVICE_DESCRIPTION[0]::string,
  try_to_number(USAGES[0]::string),
  try_to_number(USERS[0]::string),
  CURRENCY_OF_REPORTING[0]::string,
  try_to_number(NET_REVENUE[0]::string, 38, 8),
  IFF(trim(RIGHTS_CONTROLLER[0]::string)='',NULL,RIGHTS_CONTROLLER[0]::string),
  IFF(trim(RIGHTS_CONTROLLER_PARTY_ID[0]::string)='',NULL,RIGHTS_CONTROLLER_PARTY_ID[0]::string),
  ALLOCATED_USAGES,
  ALLOCATED_REVENUE,
  try_to_number(ALLOCATED_NET_REVENUE[0]::string, 38, 8),
  IFF(trim(RIGHTS_TYPE[0]::string)='',NULL,RIGHTS_TYPE[0]::string),
  CONTENT_CATEGORY[0]::string,
  IFF(trim(CURRENCY_OF_TRANSACTION[0]::string)='',NULL,CURRENCY_OF_TRANSACTION[0]::string),
  try_to_number(EXCHANGE_RATE[0]::string, 38, 8),
  try_to_number(RIGHTS_TYPE_PERCENTAGE[0]::string, 38, 8)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY02_02;


CREATE OR REPLACE VIEW SY04_01 (
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
  MUSIC_USAGE_PERCENTAGE
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  SUMMARY_RECORD_ID[0]::string,
  IFF(trim(DISTRIBUTION_CHANNEL[0]::string)='',NULL,DISTRIBUTION_CHANNEL[0]::string),
  IFF(trim(DISTRIBUTION_CHANNEL_DPID[0]::string)='',NULL,DISTRIBUTION_CHANNEL_DPID[0]::string),
  COMMERCIAL_MODEL[0]::string,
  USE_TYPE[0]::string,
  TERRITORY[0]::string,
  SERVICE_DESCRIPTION[0]::string,
  SUBSCRIBER_TYPE[0]::string,
  try_to_number(SUBSCRIBERS[0]::string, 38, 8),
  COALESCE(TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY-MM-DD'),TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY-MM'),TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY')),
  COALESCE(TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY-MM-DD'),TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY-MM'),TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY')),
  try_to_number(USAGES_IN_SUB_PERIOD[0]::string),
  try_to_number(USAGES_IN_REPORTING_PERIOD[0]::string),
  CURRENCY_OF_REPORTING[0]::string,
  IFF(trim(CURRENCY_OF_TRANSACTION[0]::string)='',NULL,CURRENCY_OF_TRANSACTION[0]::string),
  try_to_number(EXCHANGE_RATE[0]::string, 38, 8),
  try_to_number(CONSUMER_PAID_UNIT_PRICE[0]::string, 38, 8),
  try_to_number(NET_REVENUE[0]::string, 38, 8),
  try_to_number(MUSIC_USAGE_PERCENTAGE[0]::string, 38, 8)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY04_01;


CREATE OR REPLACE VIEW SY05_02 (
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
  CURRENCY,
  EXCHANGE_RATE_BASE_CURRENCY,
  EXCHANGE_RATE,
  SUBSCRIBER_TYPE,
  SUB_PERIOD_START_DATE,
  SUB_PERIOD_END_DATE,
  CONTENT_CATEGORY,
  RIGHTS_TYPE_PERCENTAGE
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  SUMMARY_RECORD_ID[0]::string,
  IFF(trim(DISTRIBUTION_CHANNEL[0]::string)='',NULL,DISTRIBUTION_CHANNEL[0]::string),
  IFF(trim(DISTRIBUTION_CHANNEL_DPID[0]::string)='',NULL,DISTRIBUTION_CHANNEL_DPID[0]::string),
  COMMERCIAL_MODEL[0]::string,
  USE_TYPE[0]::string,
  TERRITORY[0]::string,
  IFF(trim(SERVICE_DESCRIPTION[0]::string)='',NULL,SERVICE_DESCRIPTION[0]::string),
  IFF(trim(RIGHTS_CONTROLLER[0]::string)='',NULL,RIGHTS_CONTROLLER[0]::string),
  IFF(trim(RIGHTS_CONTROLLER_PARTY_ID[0]::string)='',NULL,RIGHTS_CONTROLLER_PARTY_ID[0]::string),
  RIGHTS_TYPE[0]::string,
  try_to_number(TOTAL_USAGES[0]::string),
  ALLOCATED_USAGES,
  try_to_number(MUSIC_USAGE_RATIO[0]::string, 38, 8),
  ALLOCATED_NET_REVENUE,
  try_to_number(ALLOCATED_REVENUE[0]::string, 38, 8),
  try_to_number(RIGHTS_CONTROLLER_MARKET_SHARE[0]::string, 38, 8),
  IFF(trim(CURRENCY[0]::string)='',NULL,CURRENCY[0]::string),
  IFF(trim(EXCHANGE_RATE_BASE_CURRENCY[0]::string)='',NULL,EXCHANGE_RATE_BASE_CURRENCY[0]::string),
  try_to_number(EXCHANGE_RATE[0]::string, 38, 8),
  IFF(trim(SUBSCRIBER_TYPE[0]::string)='',NULL,SUBSCRIBER_TYPE[0]::string),
  COALESCE(TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY-MM-DD'),TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY-MM'),TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY')),
  COALESCE(TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY-MM-DD'),TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY-MM'),TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY')),
  CONTENT_CATEGORY[0]::string,
  try_to_number(RIGHTS_TYPE_PERCENTAGE[0]::string, 38, 8)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SY05_02;


CREATE OR REPLACE VIEW RE01 (
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
  DATA_PROVIDER
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  RELEASE_REFERENCE[0]::string,
  DSP_RELEASE_ID[0]::string,
  PROPRIETARY_RELEASE_ID,
  IFF(trim(CATALOG_NUMBER[0]::string)='',NULL,CATALOG_NUMBER[0]::string),
  IFF(trim(ICPN[0]::string)='',NULL,ICPN[0]::string),
  DISPLAY_ARTIST_NAME[0]::string,
  IFF(trim(DISPLAY_ARTIST_PARTY_ID[0]::string)='',NULL,DISPLAY_ARTIST_PARTY_ID[0]::string),
  TITLE[0]::string,
  IFF(trim(SUB_TITLE[0]::string)='',NULL,SUB_TITLE[0]::string),
  IFF(trim(RELEASE_TYPE[0]::string)='',NULL,RELEASE_TYPE[0]::string),
  IFF(trim(LABEL[0]::string)='',NULL,LABEL[0]::string),
  IFF(trim(P_LINE[0]::string)='',NULL,P_LINE[0]::string),
  IFF(trim(DATA_PROVIDER[0]::string)='',NULL,DATA_PROVIDER[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.RE01;


CREATE OR REPLACE VIEW RE02 (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  BLOCK_ID,
  RELEASE_REFERENCE,
  DSP_SUB_RELEASE_ID,
  PROPRIETARY_SUB_RELEASE_ID,
  USED_RESOURCES
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  RELEASE_REFERENCE[0]::string,
  DSP_SUB_RELEASE_ID[0]::string,
  PROPRIETARY_SUB_RELEASE_ID,
  USED_RESOURCES
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.RE02;


CREATE OR REPLACE VIEW AS01_01 (
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
  IS_MASTER_RECORDING
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  RESOURCE_REFERENCE[0]::string,
  DSP_RESOURCE_ID[0]::string,
  IFF(trim(ISRC[0]::string)='',NULL,ISRC[0]::string),
  TITLE[0]::string,
  IFF(trim(SUB_TITLE[0]::string)='',NULL,SUB_TITLE[0]::string),
  IFF(trim(DISPLAY_ARTIST_NAME[0]::string)='',NULL,DISPLAY_ARTIST_NAME[0]::string),
  IFF(trim(DISPLAY_ARTIST_PARTY_ID[0]::string)='',NULL,DISPLAY_ARTIST_PARTY_ID[0]::string),
  IFF(trim(DURATION[0]::string)='',NULL,DURATION[0]::string),
  RESOURCE_TYPE[0]::string,
  try_to_boolean(IS_MASTER_RECORDING[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.AS01_01;


CREATE OR REPLACE VIEW AS02_02 (
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
  IS_MASTER_RECORDING
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  RESOURCE_REFERENCE[0]::string,
  DSP_RESOURCE_ID[0]::string,
  IFF(trim(ISRC[0]::string)='',NULL,ISRC[0]::string),
  TITLE[0]::string,
  IFF(trim(SUB_TITLE[0]::string)='',NULL,SUB_TITLE[0]::string),
  IFF(trim(DISPLAY_ARTIST_NAME[0]::string)='',NULL,DISPLAY_ARTIST_NAME[0]::string),
  IFF(trim(DISPLAY_ARTIST_PARTY_ID[0]::string)='',NULL,DISPLAY_ARTIST_PARTY_ID[0]::string),
  IFF(trim(DURATION[0]::string)='',NULL,DURATION[0]::string),
  RESOURCE_TYPE[0]::string,
  IFF(trim(ISWC[0]::string)='',NULL,ISWC[0]::string),
  COMPOSER_AUTHOR,
  COMPOSER_AUTHOR_PARTY_ID,
  ARRANGER,
  ARRANGER_PARTY_ID,
  MUSIC_PUBLISHER,
  MUSIC_PUBLISHER_PARTY_ID,
  WORK_CONTRIBUTOR,
  WORK_CONTRIBUTOR_PARTY_ID,
  IFF(trim(PROPRIETARY_WORK_ID[0]::string)='',NULL,PROPRIETARY_WORK_ID[0]::string),
  try_to_boolean(IS_MASTER_RECORDING[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.AS02_02;


CREATE OR REPLACE VIEW MW01_01 (
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
  PROPRIETARY_WORK_ID
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  DSP_WORK_ID[0]::string,
  IFF(trim(ISWC[0]::string)='',NULL,ISWC[0]::string),
  TITLE[0]::string,
  IFF(trim(SUB_TITLE[0]::string)='',NULL,SUB_TITLE[0]::string),
  COMPOSER_AUTHOR,
  COMPOSER_AUTHOR_PARTY_ID,
  ARRANGER,
  ARRANGER_PARTY_ID,
  MUSIC_PUBLISHER,
  MUSIC_PUBLISHER_PARTY_ID,
  WORK_CONTRIBUTOR,
  WORK_CONTRIBUTOR_PARTY_ID,
  IFF(trim(DATA_PROVIDER[0]::string)='',NULL,DATA_PROVIDER[0]::string),
  IFF(trim(PROPRIETARY_WORK_ID[0]::string)='',NULL,PROPRIETARY_WORK_ID[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.MW01_01;


CREATE OR REPLACE VIEW SU01 (
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
  PROMOTIONAL_ACTIVITY
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  SUMMARY_RECORD_ID[0]::string,
  SALES_TRANSACTION_ID[0]::string,
  IFF(trim(TRANSACTED_RELEASE[0]::string)='',NULL,TRANSACTED_RELEASE[0]::string),
  IFF(trim(TRANSACTED_RESOURCE[0]::string)='',NULL,TRANSACTED_RESOURCE[0]::string),
  try_to_boolean(IS_ROYALTY_BEARING[0]::string),
  try_to_boolean(SALES_UPGRADE[0]::string),
  try_to_number(USAGES[0]::string),
  try_to_number(RETURNS[0]::string),
  try_to_number(PRICE_CONSUMER_PAID_EXC_SALES_TAX[0]::string, 38, 8),
  IFF(trim(PROMOTIONAL_ACTIVITY[0]::string)='',NULL,PROMOTIONAL_ACTIVITY[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SU01;


CREATE OR REPLACE VIEW SU02 (
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
  PROMOTIONAL_ACTIVITY
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE[0]::string,
  BLOCK_ID[0]::string,
  SUMMARY_RECORD_ID[0]::string,
  SALES_TRANSACTION_ID[0]::string,
  IFF(trim(TRANSACTED_RELEASE[0]::string)='',NULL,TRANSACTED_RELEASE[0]::string),
  IFF(trim(TRANSACTED_RESOURCE[0]::string)='',NULL,TRANSACTED_RESOURCE[0]::string),
  try_to_boolean(IS_ROYALTY_BEARING[0]::string),
  try_to_number(NUMBER_OF_STREAMS[0]::string, 38, 8),
  try_to_number(PRICE_CONSUMER_PAID_EXC_SALES_TAX[0]::string, 38, 8),
  IFF(trim(PROMOTIONAL_ACTIVITY[0]::string)='',NULL,PROMOTIONAL_ACTIVITY[0]::string)
from %ENV%_DDEX_DSR.UNTYPED_BAP_MRB_12.SU02;


