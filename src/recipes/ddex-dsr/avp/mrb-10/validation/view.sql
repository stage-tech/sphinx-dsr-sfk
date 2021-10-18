use schema VALIDATION_AVP_MRB_10;

create or replace function is_commercial_model(value varchar)
  returns boolean
  as
  $$
    value in (
      'AdvertisementSupportedModel','AsPerContract','DeviceFeeModel','FreeOfChargeModel','PayAsYouGoModel','PerformanceRoyaltiesModel','RightsClaimModel','SubscriptionModel','Unknown','UserDefined'
    )
  $$
  ;


create or replace function is_use_type(value varchar)
  returns boolean
  as
  $$
    value in (
      'AsPerContract','Broadcast','ConditionalDownload','ContentInfluencedStream','Display','Download','DubForAdvertisement','DubForLivePerformance','DubForMovies','DubForMusicOnHold','DubForPublicPerformance','DubForRadio','DubForTV','ExtractForInternet','KioskDownload','Narrowcast','NonInteractiveStream','OnDemandStream','PerformAsMusicOnHold','PerformInLivePerformance','PerformInPublic','PermanentDownload','Playback','PlayInPublic','Podcast','Print','PrivateCopy','ProgrammedContentStream','PurchaseAsPhysicalProduct','Rent','Simulcast','Stream','TetheredDownload','TimeInfluencedStream','Unknown','UseAsAlertTone','UseAsDevice','UseAsKaraoke','UseAsRingbackTone','UseAsRingbackTune','UseAsRingtone','UseAsRingtune','UseAsScreensaver','UseAsVoiceMail','UseAsWallpaper','UseForIdentification','UseInMobilePhoneMessaging','UseInPhoneListening','UserDefined','UserMakeAvailableLabelProvided','UserMakeAvailableUserProvided','Webcast'
    )
  $$
  ;


create or replace function is_territory(value varchar)
  returns boolean
  as
  $$
    value in (
      'AD','AE','AF','AG','AI','AL','AM','AN','AO','AQ','AR','AS','AT','AU','AW','AX','AZ','BA','BB','BD','BE','BF','BG','BH','BI','BJ','BL','BM','BN','BO','BQ','BR','BS','BT','BV','BW','BY','BZ','CA','CC','CD','CF','CG','CH','CI','CK','CL','CM','CN','CO','CR','CS','CU','CV','CW','CX','CY','CZ','DE','DJ','DK','DM','DO','DZ','EC','EE','EG','EH','ER','ES','ES-CE','ES-CN','ES-ML','ET','FI','FJ','FK','FM','FO','FR','GA','GB','GD','GE','GF','GG','GH','GI','GL','GM','GN','GP','GQ','GR','GS','GT','GU','GW','GY','HK','HM','HN','HR','HT','HU','ID','IE','IL','IM','IN','IO','IQ','IR','IS','IT','JE','JM','JO','JP','KE','KG','KH','KI','KM','KN','KP','KR','KW','KY','KZ','LA','LB','LC','LI','LK','LR','LS','LT','LU','LV','LY','MA','MC','MD','ME','MF','MG','MH','MK','ML','MM','MN','MO','MP','MQ','MR','MS','MT','MU','MV','MW','MX','MY','MZ','NA','NC','NE','NF','NG','NI','NL','NO','NP','NR','NU','NZ','OM','PA','PE','PF','PG','PH','PK','PL','PM','PN','PR','PS','PT','PW','PY','QA','RE','RO','RS','RU','RW','SA','SB','SC','SD','SE','SG','SH','SI','SJ','SK','SL','SM','SN','SO','SR','SS','ST','SV','SX','SY','SZ','TC','TD','TF','TG','TH','TJ','TK','TL','TM','TN','TO','TR','TT','TV','TW','TZ','UA','UG','UM','US','UY','UZ','VA','VC','VE','VG','VI','VN','VU','WF','WS','YE','YT','ZA','ZM','ZW','4','8','12','20','24','28','31','32','36','40','44','48','50','51','52','56','64','68','70','72','76','84','90','96','100','104','108','112','116','120','124','132','140','144','148','152','156','158','170','174','178','180','188','191','192','196','200','203','204','208','212','214','218','222','226','230','231','232','233','242','246','250','258','262','266','268','270','276','278','280','288','296','300','308','320','324','328','332','336','340','344','348','352','356','360','364','368','372','376','380','384','388','392','398','400','404','408','410','414','417','418','422','426','428','430','434','438','440','442','450','454','458','462','466','470','478','480','484','492','496','498','499','504','508','512','516','520','524','528','540','548','554','558','562','566','578','583','584','585','586','591','598','600','604','608','616','620','624','626','630','634','642','643','646','659','662','670','674','678','682','686','688','690','694','702','703','704','705','706','710','716','720','724','728','729','732','736','740','748','752','756','760','762','764','768','776','780','784','788','792','795','798','800','804','807','810','818','826','834','840','854','858','860','862','882','886','887','890','891','894','2100','2101','2102','2103','2104','2105','2106','2107','2108','2109','2110','2111','2112','2113','2114','2115','2116','2117','2118','2119','2120','2121','2122','2123','2124','2125','2126','2127','2128','2129','2130','2131','2132','2133','2134','2136','Worldwide'
    )
  $$
  ;


create or replace function is_currency(value varchar)
  returns boolean
  as
  $$
    value in (
      'AED','AFN','ALL','AMD','ANG','AOA','ARS','AUD','AWG','AZN','BAM','BBD','BDT','BGN','BHD','BIF','BMD','BND','BOB','BOV','BRL','BSD','BTN','BWP','BYR','BZD','CAD','CDF','CHF','CLF','CLP','CNY','COP','COU','CRC','CUC','CUP','CVE','CZK','DJF','DKK','DOP','DZD','EGP','ERN','ETB','EUR','FJD','FKP','GBP','GEL','GHS','GIP','GMD','GNF','GTQ','GYD','HKD','HNL','HRK','HTG','HUF','IDR','ILS','INR','IQD','IRR','ISK','JMD','JOD','JPY','KES','KGS','KHR','KMF','KPW','KRW','KWD','KYD','KZT','LAK','LBP','LKR','LRD','LSL','LYD','MAD','MDL','MGA','MKD','MMK','MNT','MOP','MRU','MUR','MVR','MWK','MXN','MXV','MYR','MZN','NAD','NGN','NIO','NOK','NPR','NZD','OMR','PAB','PEN','PGK','PHP','PKR','PLN','PYG','QAR','RON','RSD','RUB','RWF','SAR','SBD','SCR','SDG','SEK','SGD','SHP','SLL','SOS','SRD','SSP','STN','SVC','SYP','SZL','THB','TJS','TMT','TND','TOP','TRY','TTD','TWD','TZS','UAH','UGX','USD','UYI','UYU','UZS','VES','VND','VUV','WST','XAF','XCD','XOF','XPF','YER','ZAR','ZMW','ZWL','CYP','EEK','LTL','LVL','MTL','MRO','ROL','SIT','SKK','STD','VEF'
    )
  $$
  ;


create or replace function is_language(value varchar)
  returns boolean
  as
  $$
    value in (
      'aa','ab','ae','af','ak','am','an','ar','as','av','ay','az','ba','be','bg','bh','bm','bi','bn','bo','br','bs','ca','ce','ch','co','cr','cs','cu','cv','cy','da','de','dv','dz','ee','el','en','eo','es','et','eu','fa','ff','fi','fj','fo','fr','fy','ga','gd','gl','gn','gu','gv','ha','he','hi','ho','hr','ht','hu','hy','hz','ia','id','ie','ig','ii','ik','io','is','it','iu','ja','jv','ka','kg','ki','kj','kk','kl','km','kn','ko','kr','ks','ku','kv','kw','ky','la','lb','lg','li','ln','lo','lt','lu','lv','mg','mh','mi','mk','ml','mn','mr','ms','mt','my','na','nb','nd','ne','ng','nl','nn','no','nr','nv','ny','oc','oj','om','or','os','pa','pi','pl','ps','pt','qu','rm','rn','ro','ru','rw','sa','sc','sd','se','sg','si','sk','sl','sm','sn','so','sq','sr','ss','st','su','sv','sw','ta','te','tg','th','ti','tk','tl','tn','to','tr','ts','tt','tw','ty','ug','uk','ur','uz','ve','vi','vo','wa','wo','xh','yi','yo','za','zh','zu'
    )
  $$
  ;


create or replace function is_release_type(value varchar)
  returns boolean
  as
  $$
    value in (
      'AdvertisementVideo','Album','AlertToneRelease','Animation','AsPerContract','AudioBookRelease','AudioClipRelease','BackCoverImageRelease','BookletBackImageRelease','BookletFrontImageRelease','BookletRelease','Bundle','ClassicalAlbum','ConcertVideo','CorporateFilm','DigitalBoxSetRelease','Documentary','DocumentImageRelease','EBookRelease','Episode','FeatureFilm','FilmBundle','FrontCoverImageRelease','IconRelease','InfomercialVideo','InteractiveBookletRelease','KaraokeRelease','LiveEventVideo','LogoRelease','LongFormMusicalWorkVideoRelease','LongFormNonMusicalWorkVideoRelease','LyricSheetRelease','MultimediaAlbum','MultimediaSingle','MusicalWorkBasedGameRelease','MusicalWorkClipRelease','MusicalWorkReadalongVideoRelease','MusicalWorkTrailerRelease','MusicalWorkVideoChapterRelease','News','NonMusicalWorkBasedGameRelease','NonMusicalWorkClipRelease','NonMusicalWorkReadalongVideoRelease','NonMusicalWorkTrailerRelease','NonMusicalWorkVideoChapterRelease','NonSerialAudioVisualRecording','PhotographRelease','RingbackToneRelease','RingtoneRelease','ScreensaverRelease','Season','Series','SheetMusicRelease','ShortFormMusicalWorkVideoRelease','ShortFormNonMusicalWorkVideoRelease','Single','SingleResourceRelease','SingleResourceReleaseWithCoverArt','TrackRelease','TrailerVideo','TrayImageRelease','Unknown','UserDefined','VideoAlbum','VideoChapterRelease','VideoClipRelease','VideoScreenCaptureRelease','VideoSingle','VideoTrackRelease','WallpaperRelease'
    )
  $$
  ;


create or replace function is_video_type(value varchar)
  returns boolean
  as
  $$
    value in (
      'AdvertisementVideo','AdultContent','AdviceMagazine','Animation','BalletVideo','BehindTheScenes','BlackAndWhiteVideo','ChildrensFilm','ColorizedVideo','ColumnVideo','ConcertClip','ConcertVideo','CorporateFilm','Credits','Documentary','EducationalVideo','Episode','FeatureFilm','Fiction','InfomercialVideo','Interview','Karaoke','LiveEventVideo','LongformMusicalWorkVideo','LongformNonMusicalWorkVideo','LyricVideo','Magazine','Menu','MultimediaVideo','MusicalWorkClip','MusicalWorkReadalongVideo','MusicalWorkTrailer','MusicalWorkVideoChapter','News','NonMusicalWorkCliop','NonMusicalWorkReadalongVideo','NonMusicalWorkTrailer','NonMusicalWorkVideoChapter','NonSerialAudioVisualRecording','OperaVideo','Performance','ReadalongVideo','RealityTvShowVideo','Season','SerialAudioVisualRecording','Series','ShortFilm','SilentVideo','SketchVideo','SoapSitcom','SpecialEvent','Sport','TheatricalWorkVideo','TrailerVideo','TvFilm','TvProgram','TvShowVideo','Unknown','VideoChapter','VideoClip','VideoReport','VideoStem'
    )
  $$
  ;


CREATE OR REPLACE VIEW HEAD_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  'HEAD',
  ARRAY_CONSTRUCT_COMPACT(
    IFF(RECORD_TYPE is not null AND ARRAY_SIZE(RECORD_TYPE) >= 1, null, 'RECORD_TYPE_REQUIRED'),
    IFF(RECORD_TYPE is null OR ARRAY_SIZE(RECORD_TYPE) <= 1, null, 'RECORD_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RECORD_TYPE[0] is null, null, IFF(RECORD_TYPE[0]::string IN ('HEAD'), null, 'RECORD_TYPE_NOT_ALLOWED_VALUE')),
    IFF(MESSAGE_VERSION is not null AND ARRAY_SIZE(MESSAGE_VERSION) >= 1, null, 'MESSAGE_VERSION_REQUIRED'),
    IFF(MESSAGE_VERSION is null OR ARRAY_SIZE(MESSAGE_VERSION) <= 1, null, 'MESSAGE_VERSION_HAS_MULTIPLE_ITEMS'),
    IFF(MESSAGE_VERSION[0] is null, null, IFF(MESSAGE_VERSION[0]::string REGEXP 'dsrf(\/30|(\/\\d+(\.\\d+){0,2}){3})', null, 'MESSAGE_VERSION_NOT_ALLOWED_PATTERN')),
    IFF(PROFILE is not null AND ARRAY_SIZE(PROFILE) >= 1, null, 'PROFILE_REQUIRED'),
    IFF(PROFILE is null OR ARRAY_SIZE(PROFILE) <= 1, null, 'PROFILE_HAS_MULTIPLE_ITEMS'),
    IFF(PROFILE[0] is null, null, IFF(PROFILE[0]::string REGEXP 'Audio\\s*Visual\\s*Profile', null, 'PROFILE_NOT_ALLOWED_PATTERN')),
    IFF(PROFILE_VERSION is not null AND ARRAY_SIZE(PROFILE_VERSION) >= 1, null, 'PROFILE_VERSION_REQUIRED'),
    IFF(PROFILE_VERSION is null OR ARRAY_SIZE(PROFILE_VERSION) <= 1, null, 'PROFILE_VERSION_HAS_MULTIPLE_ITEMS'),
    IFF(PROFILE_VERSION[0] is null, null, IFF(PROFILE_VERSION[0]::string IN ('1.0'), null, 'PROFILE_VERSION_NOT_ALLOWED_VALUE')),
    IFF(MESSAGE_ID is not null AND ARRAY_SIZE(MESSAGE_ID) >= 1, null, 'MESSAGE_ID_REQUIRED'),
    IFF(MESSAGE_ID is null OR ARRAY_SIZE(MESSAGE_ID) <= 1, null, 'MESSAGE_ID_HAS_MULTIPLE_ITEMS'),
    IFF(MESSAGE_CREATED_DATE_TIME is not null AND ARRAY_SIZE(MESSAGE_CREATED_DATE_TIME) >= 1, null, 'MESSAGE_CREATED_DATE_TIME_REQUIRED'),
    IFF(MESSAGE_CREATED_DATE_TIME is null OR ARRAY_SIZE(MESSAGE_CREATED_DATE_TIME) <= 1, null, 'MESSAGE_CREATED_DATE_TIME_HAS_MULTIPLE_ITEMS'),
    IFF(MESSAGE_CREATED_DATE_TIME[0] is null, null, 
      IFF(TRY_TO_TIMESTAMP(MESSAGE_CREATED_DATE_TIME[0]::string, 'YYYY-MM-DDTHH24:MI:SSZ') is not null, null, 'MESSAGE_CREATED_DATE_TIME_NOT_DATETIME')),
    IFF(FILE_NUMBER is not null AND ARRAY_SIZE(FILE_NUMBER) >= 1, null, 'FILE_NUMBER_REQUIRED'),
    IFF(FILE_NUMBER is null OR ARRAY_SIZE(FILE_NUMBER) <= 1, null, 'FILE_NUMBER_HAS_MULTIPLE_ITEMS'),
    IFF(FILE_NUMBER[0] is null, null, IFF(FILE_NUMBER[0]::string REGEXP '\\d+', null, 'FILE_NUMBER_NOT_INTEGER')),
    IFF(NUMBER_OF_FILES is not null AND ARRAY_SIZE(NUMBER_OF_FILES) >= 1, null, 'NUMBER_OF_FILES_REQUIRED'),
    IFF(NUMBER_OF_FILES is null OR ARRAY_SIZE(NUMBER_OF_FILES) <= 1, null, 'NUMBER_OF_FILES_HAS_MULTIPLE_ITEMS'),
    IFF(NUMBER_OF_FILES[0] is null, null, IFF(NUMBER_OF_FILES[0]::string REGEXP '\\d+', null, 'NUMBER_OF_FILES_NOT_INTEGER')),
    IFF(USAGE_START_DATE is not null AND ARRAY_SIZE(USAGE_START_DATE) >= 1, null, 'USAGE_START_DATE_REQUIRED'),
    IFF(USAGE_START_DATE is null OR ARRAY_SIZE(USAGE_START_DATE) <= 1, null, 'USAGE_START_DATE_HAS_MULTIPLE_ITEMS'),
    IFF(USAGE_START_DATE[0] is null, null, 
      IFF(TRY_TO_DATE(USAGE_START_DATE[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(USAGE_START_DATE[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(USAGE_START_DATE[0]::string, 'YYYY') is not null, null, 'USAGE_START_DATE_NOT_DATE')))),
    IFF(USAGE_END_DATE is not null AND ARRAY_SIZE(USAGE_END_DATE) >= 1, null, 'USAGE_END_DATE_REQUIRED'),
    IFF(USAGE_END_DATE is null OR ARRAY_SIZE(USAGE_END_DATE) <= 1, null, 'USAGE_END_DATE_HAS_MULTIPLE_ITEMS'),
    IFF(USAGE_END_DATE[0] is null, null, 
      IFF(TRY_TO_DATE(USAGE_END_DATE[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(USAGE_END_DATE[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(USAGE_END_DATE[0]::string, 'YYYY') is not null, null, 'USAGE_END_DATE_NOT_DATE')))),
    IFF(SENDER_PARTY_ID is not null AND ARRAY_SIZE(SENDER_PARTY_ID) >= 1, null, 'SENDER_PARTY_ID_REQUIRED'),
    IFF(SENDER_PARTY_ID is null OR ARRAY_SIZE(SENDER_PARTY_ID) <= 1, null, 'SENDER_PARTY_ID_HAS_MULTIPLE_ITEMS'),
    IFF(SENDER_PARTY_ID[0] is null, null, IFF(SENDER_PARTY_ID[0]::string REGEXP 'PADPIDA[0-9A-Za-z]{11}', null, 'SENDER_PARTY_ID_NOT_ALLOWED_PATTERN')),
    IFF(SENDER_NAME is not null AND ARRAY_SIZE(SENDER_NAME) >= 1, null, 'SENDER_NAME_REQUIRED'),
    IFF(SENDER_NAME is null OR ARRAY_SIZE(SENDER_NAME) <= 1, null, 'SENDER_NAME_HAS_MULTIPLE_ITEMS'),
    IFF(SERVICE_DESCRIPTION is null OR ARRAY_SIZE(SERVICE_DESCRIPTION) <= 1, null, 'SERVICE_DESCRIPTION_HAS_MULTIPLE_ITEMS'),
    IFF(RECIPIENT_PARTY_ID is null OR ARRAY_SIZE(RECIPIENT_PARTY_ID) <= 1, null, 'RECIPIENT_PARTY_ID_HAS_MULTIPLE_ITEMS'),
    IFF(RECIPIENT_PARTY_ID[0] is null, null, IFF(RECIPIENT_PARTY_ID[0]::string REGEXP 'PADPIDA[0-9A-Za-z]{11}', null, 'RECIPIENT_PARTY_ID_NOT_ALLOWED_PATTERN')),
    IFF(RECIPIENT_NAME is null OR ARRAY_SIZE(RECIPIENT_NAME) <= 1, null, 'RECIPIENT_NAME_HAS_MULTIPLE_ITEMS')
  )
from %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.HEAD;


CREATE OR REPLACE VIEW FOOT_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  'FOOT',
  ARRAY_CONSTRUCT_COMPACT(
    IFF(RECORD_TYPE is not null AND ARRAY_SIZE(RECORD_TYPE) >= 1, null, 'RECORD_TYPE_REQUIRED'),
    IFF(RECORD_TYPE is null OR ARRAY_SIZE(RECORD_TYPE) <= 1, null, 'RECORD_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RECORD_TYPE[0] is null, null, IFF(RECORD_TYPE[0]::string IN ('FOOT'), null, 'RECORD_TYPE_NOT_ALLOWED_VALUE')),
    IFF(NUMBER_OF_LINES_IN_FILE is not null AND ARRAY_SIZE(NUMBER_OF_LINES_IN_FILE) >= 1, null, 'NUMBER_OF_LINES_IN_FILE_REQUIRED'),
    IFF(NUMBER_OF_LINES_IN_FILE is null OR ARRAY_SIZE(NUMBER_OF_LINES_IN_FILE) <= 1, null, 'NUMBER_OF_LINES_IN_FILE_HAS_MULTIPLE_ITEMS'),
    IFF(NUMBER_OF_LINES_IN_FILE[0] is null, null, IFF(NUMBER_OF_LINES_IN_FILE[0]::string REGEXP '\\d+', null, 'NUMBER_OF_LINES_IN_FILE_NOT_INTEGER')),
    IFF(NUMBER_OF_LINES_IN_REPORT is null OR ARRAY_SIZE(NUMBER_OF_LINES_IN_REPORT) <= 1, null, 'NUMBER_OF_LINES_IN_REPORT_HAS_MULTIPLE_ITEMS'),
    IFF(NUMBER_OF_LINES_IN_REPORT[0] is null, null, IFF(NUMBER_OF_LINES_IN_REPORT[0]::string REGEXP '\\d+', null, 'NUMBER_OF_LINES_IN_REPORT_NOT_INTEGER')),
    IFF(NUMBER_OF_SUMMARY_RECORDS is not null AND ARRAY_SIZE(NUMBER_OF_SUMMARY_RECORDS) >= 1, null, 'NUMBER_OF_SUMMARY_RECORDS_REQUIRED'),
    IFF(NUMBER_OF_SUMMARY_RECORDS is null OR ARRAY_SIZE(NUMBER_OF_SUMMARY_RECORDS) <= 1, null, 'NUMBER_OF_SUMMARY_RECORDS_HAS_MULTIPLE_ITEMS'),
    IFF(NUMBER_OF_SUMMARY_RECORDS[0] is null, null, IFF(NUMBER_OF_SUMMARY_RECORDS[0]::string REGEXP '\\d+', null, 'NUMBER_OF_SUMMARY_RECORDS_NOT_INTEGER')),
    IFF(NUMBER_OF_BLOCKS_IN_FILE is not null AND ARRAY_SIZE(NUMBER_OF_BLOCKS_IN_FILE) >= 1, null, 'NUMBER_OF_BLOCKS_IN_FILE_REQUIRED'),
    IFF(NUMBER_OF_BLOCKS_IN_FILE is null OR ARRAY_SIZE(NUMBER_OF_BLOCKS_IN_FILE) <= 1, null, 'NUMBER_OF_BLOCKS_IN_FILE_HAS_MULTIPLE_ITEMS'),
    IFF(NUMBER_OF_BLOCKS_IN_FILE[0] is null, null, IFF(NUMBER_OF_BLOCKS_IN_FILE[0]::string REGEXP '\\d+', null, 'NUMBER_OF_BLOCKS_IN_FILE_NOT_INTEGER')),
    IFF(NUMBER_OF_BLOCKS_IN_REPORT is null OR ARRAY_SIZE(NUMBER_OF_BLOCKS_IN_REPORT) <= 1, null, 'NUMBER_OF_BLOCKS_IN_REPORT_HAS_MULTIPLE_ITEMS'),
    IFF(NUMBER_OF_BLOCKS_IN_REPORT[0] is null, null, IFF(NUMBER_OF_BLOCKS_IN_REPORT[0]::string REGEXP '\\d+', null, 'NUMBER_OF_BLOCKS_IN_REPORT_NOT_INTEGER'))
  )
from %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.FOOT;


CREATE OR REPLACE VIEW SY04_01_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  'SY04.01',
  ARRAY_CONSTRUCT_COMPACT(
    IFF(RECORD_TYPE is not null AND ARRAY_SIZE(RECORD_TYPE) >= 1, null, 'RECORD_TYPE_REQUIRED'),
    IFF(RECORD_TYPE is null OR ARRAY_SIZE(RECORD_TYPE) <= 1, null, 'RECORD_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RECORD_TYPE[0] is null, null, IFF(RECORD_TYPE[0]::string IN ('SY04.01'), null, 'RECORD_TYPE_NOT_ALLOWED_VALUE')),
    IFF(SUMMARY_RECORD_ID is not null AND ARRAY_SIZE(SUMMARY_RECORD_ID) >= 1, null, 'SUMMARY_RECORD_ID_REQUIRED'),
    IFF(SUMMARY_RECORD_ID is null OR ARRAY_SIZE(SUMMARY_RECORD_ID) <= 1, null, 'SUMMARY_RECORD_ID_HAS_MULTIPLE_ITEMS'),
    IFF(DISTRIBUTION_CHANNEL is null OR ARRAY_SIZE(DISTRIBUTION_CHANNEL) <= 1, null, 'DISTRIBUTION_CHANNEL_HAS_MULTIPLE_ITEMS'),
    IFF(DISTRIBUTION_CHANNEL_DPID is null OR ARRAY_SIZE(DISTRIBUTION_CHANNEL_DPID) <= 1, null, 'DISTRIBUTION_CHANNEL_DPID_HAS_MULTIPLE_ITEMS'),
    IFF(DISTRIBUTION_CHANNEL_DPID[0] is null, null, IFF(DISTRIBUTION_CHANNEL_DPID[0]::string REGEXP 'PADPIDA[0-9A-Za-z]{11}', null, 'DISTRIBUTION_CHANNEL_DPID_NOT_ALLOWED_PATTERN')),
    IFF(COMMERCIAL_MODEL is not null AND ARRAY_SIZE(COMMERCIAL_MODEL) >= 1, null, 'COMMERCIAL_MODEL_REQUIRED'),
    IFF(COMMERCIAL_MODEL is null OR ARRAY_SIZE(COMMERCIAL_MODEL) <= 1, null, 'COMMERCIAL_MODEL_HAS_MULTIPLE_ITEMS'),
    IFF(COMMERCIAL_MODEL[0] is null, null, IFF(is_commercial_model(COMMERCIAL_MODEL[0]::string), null, 'COMMERCIAL_MODEL_NOT_ALLOWED_VALUE')),
    IFF(USE_TYPE is null OR ARRAY_SIZE(USE_TYPE) <= 1, null, 'USE_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(USE_TYPE[0] is null, null, IFF(is_use_type(USE_TYPE[0]::string), null, 'USE_TYPE_NOT_ALLOWED_VALUE')),
    IFF(TERRITORY is not null AND ARRAY_SIZE(TERRITORY) >= 1, null, 'TERRITORY_REQUIRED'),
    IFF(TERRITORY is null OR ARRAY_SIZE(TERRITORY) <= 1, null, 'TERRITORY_HAS_MULTIPLE_ITEMS'),
    IFF(TERRITORY[0] is null, null, IFF(is_territory(TERRITORY[0]::string), null, 'TERRITORY_NOT_ALLOWED_VALUE')),
    IFF(SERVICE_DESCRIPTION is not null AND ARRAY_SIZE(SERVICE_DESCRIPTION) >= 1, null, 'SERVICE_DESCRIPTION_REQUIRED'),
    IFF(SERVICE_DESCRIPTION is null OR ARRAY_SIZE(SERVICE_DESCRIPTION) <= 1, null, 'SERVICE_DESCRIPTION_HAS_MULTIPLE_ITEMS'),
    IFF(SUBSCRIBER_TYPE is not null AND ARRAY_SIZE(SUBSCRIBER_TYPE) >= 1, null, 'SUBSCRIBER_TYPE_REQUIRED'),
    IFF(SUBSCRIBER_TYPE is null OR ARRAY_SIZE(SUBSCRIBER_TYPE) <= 1, null, 'SUBSCRIBER_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(SUBSCRIBERS is not null AND ARRAY_SIZE(SUBSCRIBERS) >= 1, null, 'SUBSCRIBERS_REQUIRED'),
    IFF(SUBSCRIBERS is null OR ARRAY_SIZE(SUBSCRIBERS) <= 1, null, 'SUBSCRIBERS_HAS_MULTIPLE_ITEMS'),
    IFF(SUBSCRIBERS[0] is null, null, IFF(SUBSCRIBERS[0]::string REGEXP '\\d+(\.\\d+)?', null, 'SUBSCRIBERS_NOT_DECIMAL')),
    IFF(SUB_PERIOD_START_DATE is null OR ARRAY_SIZE(SUB_PERIOD_START_DATE) <= 1, null, 'SUB_PERIOD_START_DATE_HAS_MULTIPLE_ITEMS'),
    IFF(SUB_PERIOD_START_DATE[0] is null, null, 
      IFF(TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(SUB_PERIOD_START_DATE[0]::string, 'YYYY') is not null, null, 'SUB_PERIOD_START_DATE_NOT_DATE')))),
    IFF(SUB_PERIOD_END_DATE is null OR ARRAY_SIZE(SUB_PERIOD_END_DATE) <= 1, null, 'SUB_PERIOD_END_DATE_HAS_MULTIPLE_ITEMS'),
    IFF(SUB_PERIOD_END_DATE[0] is null, null, 
      IFF(TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(SUB_PERIOD_END_DATE[0]::string, 'YYYY') is not null, null, 'SUB_PERIOD_END_DATE_NOT_DATE')))),
    IFF(USAGES_IN_SUB_PERIOD is null OR ARRAY_SIZE(USAGES_IN_SUB_PERIOD) <= 1, null, 'USAGES_IN_SUB_PERIOD_HAS_MULTIPLE_ITEMS'),
    IFF(USAGES_IN_SUB_PERIOD[0] is null, null, IFF(USAGES_IN_SUB_PERIOD[0]::string REGEXP '\\d+', null, 'USAGES_IN_SUB_PERIOD_NOT_INTEGER')),
    IFF(USAGES_IN_REPORTING_PERIOD is null OR ARRAY_SIZE(USAGES_IN_REPORTING_PERIOD) <= 1, null, 'USAGES_IN_REPORTING_PERIOD_HAS_MULTIPLE_ITEMS'),
    IFF(USAGES_IN_REPORTING_PERIOD[0] is null, null, IFF(USAGES_IN_REPORTING_PERIOD[0]::string REGEXP '\\d+', null, 'USAGES_IN_REPORTING_PERIOD_NOT_INTEGER')),
    IFF(CURRENCY_OF_REPORTING is not null AND ARRAY_SIZE(CURRENCY_OF_REPORTING) >= 1, null, 'CURRENCY_OF_REPORTING_REQUIRED'),
    IFF(CURRENCY_OF_REPORTING is null OR ARRAY_SIZE(CURRENCY_OF_REPORTING) <= 1, null, 'CURRENCY_OF_REPORTING_HAS_MULTIPLE_ITEMS'),
    IFF(CURRENCY_OF_REPORTING[0] is null, null, IFF(is_currency(CURRENCY_OF_REPORTING[0]::string), null, 'CURRENCY_OF_REPORTING_NOT_ALLOWED_VALUE')),
    IFF(CURRENCY_OF_TRANSACTION is null OR ARRAY_SIZE(CURRENCY_OF_TRANSACTION) <= 1, null, 'CURRENCY_OF_TRANSACTION_HAS_MULTIPLE_ITEMS'),
    IFF(CURRENCY_OF_TRANSACTION[0] is null, null, IFF(is_currency(CURRENCY_OF_TRANSACTION[0]::string), null, 'CURRENCY_OF_TRANSACTION_NOT_ALLOWED_VALUE')),
    IFF(EXCHANGE_RATE is null OR ARRAY_SIZE(EXCHANGE_RATE) <= 1, null, 'EXCHANGE_RATE_HAS_MULTIPLE_ITEMS'),
    IFF(EXCHANGE_RATE[0] is null, null, IFF(EXCHANGE_RATE[0]::string REGEXP '\\d+(\.\\d+)?', null, 'EXCHANGE_RATE_NOT_DECIMAL')),
    IFF(CONSUMER_PAID_UNIT_PRICE is not null AND ARRAY_SIZE(CONSUMER_PAID_UNIT_PRICE) >= 1, null, 'CONSUMER_PAID_UNIT_PRICE_REQUIRED'),
    IFF(CONSUMER_PAID_UNIT_PRICE is null OR ARRAY_SIZE(CONSUMER_PAID_UNIT_PRICE) <= 1, null, 'CONSUMER_PAID_UNIT_PRICE_HAS_MULTIPLE_ITEMS'),
    IFF(CONSUMER_PAID_UNIT_PRICE[0] is null, null, IFF(CONSUMER_PAID_UNIT_PRICE[0]::string REGEXP '\\d+(\.\\d+)?', null, 'CONSUMER_PAID_UNIT_PRICE_NOT_DECIMAL')),
    IFF(NET_REVENUE is not null AND ARRAY_SIZE(NET_REVENUE) >= 1, null, 'NET_REVENUE_REQUIRED'),
    IFF(NET_REVENUE is null OR ARRAY_SIZE(NET_REVENUE) <= 1, null, 'NET_REVENUE_HAS_MULTIPLE_ITEMS'),
    IFF(NET_REVENUE[0] is null, null, IFF(NET_REVENUE[0]::string REGEXP '\\d+(\.\\d+)?', null, 'NET_REVENUE_NOT_DECIMAL')),
    IFF(MUSIC_USAGE_PERCENTAGE is not null AND ARRAY_SIZE(MUSIC_USAGE_PERCENTAGE) >= 1, null, 'MUSIC_USAGE_PERCENTAGE_REQUIRED'),
    IFF(MUSIC_USAGE_PERCENTAGE is null OR ARRAY_SIZE(MUSIC_USAGE_PERCENTAGE) <= 1, null, 'MUSIC_USAGE_PERCENTAGE_HAS_MULTIPLE_ITEMS'),
    IFF(MUSIC_USAGE_PERCENTAGE[0] is null, null, IFF(MUSIC_USAGE_PERCENTAGE[0]::string REGEXP '\\d+(\.\\d+)?', null, 'MUSIC_USAGE_PERCENTAGE_NOT_DECIMAL')),
    IFF(MUSIC_USAGE_PERCENTAGE[0] is null, null, IFF(MUSIC_USAGE_PERCENTAGE[0]::number <= 100, null, 'MUSIC_USAGE_PERCENTAGE_GREATER_THAN_MAX_SIZE'))
  )
from %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.SY04_01;


CREATE OR REPLACE VIEW RE03_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  'RE03',
  ARRAY_CONSTRUCT_COMPACT(
    IFF(RECORD_TYPE is not null AND ARRAY_SIZE(RECORD_TYPE) >= 1, null, 'RECORD_TYPE_REQUIRED'),
    IFF(RECORD_TYPE is null OR ARRAY_SIZE(RECORD_TYPE) <= 1, null, 'RECORD_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RECORD_TYPE[0] is null, null, IFF(RECORD_TYPE[0]::string IN ('RE03'), null, 'RECORD_TYPE_NOT_ALLOWED_VALUE')),
    IFF(BLOCK_ID is not null AND ARRAY_SIZE(BLOCK_ID) >= 1, null, 'BLOCK_ID_REQUIRED'),
    IFF(BLOCK_ID is null OR ARRAY_SIZE(BLOCK_ID) <= 1, null, 'BLOCK_ID_HAS_MULTIPLE_ITEMS'),
    IFF(RELEASE_REFERENCE is not null AND ARRAY_SIZE(RELEASE_REFERENCE) >= 1, null, 'RELEASE_REFERENCE_REQUIRED'),
    IFF(RELEASE_REFERENCE is null OR ARRAY_SIZE(RELEASE_REFERENCE) <= 1, null, 'RELEASE_REFERENCE_HAS_MULTIPLE_ITEMS'),
    IFF(DSP_RELEASE_ID is not null AND ARRAY_SIZE(DSP_RELEASE_ID) >= 1, null, 'DSP_RELEASE_ID_REQUIRED'),
    IFF(DSP_RELEASE_ID is null OR ARRAY_SIZE(DSP_RELEASE_ID) <= 1, null, 'DSP_RELEASE_ID_HAS_MULTIPLE_ITEMS'),
    IFF(ICPN is null OR ARRAY_SIZE(ICPN) <= 1, null, 'ICPN_HAS_MULTIPLE_ITEMS'),
    IFF(TITLE is not null AND ARRAY_SIZE(TITLE) >= 1, null, 'TITLE_REQUIRED'),
    IFF(TITLE is null OR ARRAY_SIZE(TITLE) <= 1, null, 'TITLE_HAS_MULTIPLE_ITEMS'),
    IFF(SUB_TITLE is null OR ARRAY_SIZE(SUB_TITLE) <= 1, null, 'SUB_TITLE_HAS_MULTIPLE_ITEMS'),
    IFF(SERIES_TITLE is null OR ARRAY_SIZE(SERIES_TITLE) <= 1, null, 'SERIES_TITLE_HAS_MULTIPLE_ITEMS'),
    IFF(SEASON_NUMBER is null OR ARRAY_SIZE(SEASON_NUMBER) <= 1, null, 'SEASON_NUMBER_HAS_MULTIPLE_ITEMS'),
    IFF(SEASON_NUMBER[0] is null, null, IFF(SEASON_NUMBER[0]::string REGEXP '\\d+', null, 'SEASON_NUMBER_NOT_INTEGER')),
    IFF(DISPLAY_ARTIST_NAME is null OR ARRAY_SIZE(DISPLAY_ARTIST_NAME) <= 1, null, 'DISPLAY_ARTIST_NAME_HAS_MULTIPLE_ITEMS'),
    IFF(DISPLAY_ARTIST_PARTY_ID is null OR ARRAY_SIZE(DISPLAY_ARTIST_PARTY_ID) <= 1, null, 'DISPLAY_ARTIST_PARTY_ID_HAS_MULTIPLE_ITEMS'),
    IFF(DISPLAY_ARTIST_PARTY_ID[0] is null, null, IFF(DISPLAY_ARTIST_PARTY_ID[0]::string REGEXP 'INSI::\\d{16}', null, 'DISPLAY_ARTIST_PARTY_ID_NOT_ALLOWED_PATTERN')),
    IFF(RELEASE_TYPE is null OR ARRAY_SIZE(RELEASE_TYPE) <= 1, null, 'RELEASE_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RELEASE_TYPE[0] is null, null, IFF(is_release_type(RELEASE_TYPE[0]::string), null, 'RELEASE_TYPE_NOT_ALLOWED_VALUE')),
    IFF(DATA_PROVIDER_NAME is null OR ARRAY_SIZE(DATA_PROVIDER_NAME) <= 1, null, 'DATA_PROVIDER_NAME_HAS_MULTIPLE_ITEMS')
  )
from %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.RE03;


CREATE OR REPLACE VIEW AS03_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  'AS03',
  ARRAY_CONSTRUCT_COMPACT(
    IFF(RECORD_TYPE is not null AND ARRAY_SIZE(RECORD_TYPE) >= 1, null, 'RECORD_TYPE_REQUIRED'),
    IFF(RECORD_TYPE is null OR ARRAY_SIZE(RECORD_TYPE) <= 1, null, 'RECORD_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RECORD_TYPE[0] is null, null, IFF(RECORD_TYPE[0]::string IN ('AS03'), null, 'RECORD_TYPE_NOT_ALLOWED_VALUE')),
    IFF(BLOCK_ID is not null AND ARRAY_SIZE(BLOCK_ID) >= 1, null, 'BLOCK_ID_REQUIRED'),
    IFF(BLOCK_ID is null OR ARRAY_SIZE(BLOCK_ID) <= 1, null, 'BLOCK_ID_HAS_MULTIPLE_ITEMS'),
    IFF(RESOURCE_REFERENCE is not null AND ARRAY_SIZE(RESOURCE_REFERENCE) >= 1, null, 'RESOURCE_REFERENCE_REQUIRED'),
    IFF(RESOURCE_REFERENCE is null OR ARRAY_SIZE(RESOURCE_REFERENCE) <= 1, null, 'RESOURCE_REFERENCE_HAS_MULTIPLE_ITEMS'),
    IFF(DSP_RESOURCE_ID is not null AND ARRAY_SIZE(DSP_RESOURCE_ID) >= 1, null, 'DSP_RESOURCE_ID_REQUIRED'),
    IFF(DSP_RESOURCE_ID is null OR ARRAY_SIZE(DSP_RESOURCE_ID) <= 1, null, 'DSP_RESOURCE_ID_HAS_MULTIPLE_ITEMS'),
    IFF(ISAN is null OR ARRAY_SIZE(ISAN) <= 1, null, 'ISAN_HAS_MULTIPLE_ITEMS'),
    IFF(ISAN[0] is null, null, IFF(ISAN[0]::string REGEXP '([0-9A-Fa-f]{4}-?){3}([0-9A-Fa-f]{4}(-?[\\w\\d])?(-?([0-9A-Fa-f]{4}-?){2}[\\w\\d]?)?)', null, 'ISAN_NOT_ALLOWED_PATTERN')),
    IFF(EIDR is null OR ARRAY_SIZE(EIDR) <= 1, null, 'EIDR_HAS_MULTIPLE_ITEMS'),
    IFF(EIDR[0] is null, null, IFF(EIDR[0]::string REGEXP '\\d{2}\.\\d{4}\/([0-9A-Fa-f]{4}-?){5}\\w', null, 'EIDR_NOT_ALLOWED_PATTERN')),
    IFF(PROPRIETARY_ID is null OR ARRAY_SIZE(PROPRIETARY_ID) <= 1, null, 'PROPRIETARY_ID_HAS_MULTIPLE_ITEMS'),
    IFF(PROPRIETARY_ID[0] is null, null, IFF(PROPRIETARY_ID[0]::string REGEXP '\.+::\.+', null, 'PROPRIETARY_ID_NOT_ALLOWED_PATTERN')),
    IFF(VIDEO_TYPE is not null AND ARRAY_SIZE(VIDEO_TYPE) >= 1, null, 'VIDEO_TYPE_REQUIRED'),
    IFF(VIDEO_TYPE is null OR ARRAY_SIZE(VIDEO_TYPE) <= 1, null, 'VIDEO_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(VIDEO_TYPE[0] is null, null, IFF(is_video_type(VIDEO_TYPE[0]::string), null, 'VIDEO_TYPE_NOT_ALLOWED_VALUE')),
    IFF(TITLE is not null AND ARRAY_SIZE(TITLE) >= 1, null, 'TITLE_REQUIRED'),
    IFF(TITLE is null OR ARRAY_SIZE(TITLE) <= 1, null, 'TITLE_HAS_MULTIPLE_ITEMS'),
    IFF(SUB_TITLE is null OR ARRAY_SIZE(SUB_TITLE) <= 1, null, 'SUB_TITLE_HAS_MULTIPLE_ITEMS'),
    IFF(ORIGINAL_TITLE is null OR ARRAY_SIZE(ORIGINAL_TITLE) <= 1, null, 'ORIGINAL_TITLE_HAS_MULTIPLE_ITEMS'),
    IFF(SEASON_NUMBER is null OR ARRAY_SIZE(SEASON_NUMBER) <= 1, null, 'SEASON_NUMBER_HAS_MULTIPLE_ITEMS'),
    IFF(SEASON_NUMBER[0] is null, null, IFF(SEASON_NUMBER[0]::string REGEXP '\\d+', null, 'SEASON_NUMBER_NOT_INTEGER')),
    IFF(EPISODE_NUMBER is null OR ARRAY_SIZE(EPISODE_NUMBER) <= 1, null, 'EPISODE_NUMBER_HAS_MULTIPLE_ITEMS'),
    IFF(EPISODE_NUMBER[0] is null, null, IFF(EPISODE_NUMBER[0]::string REGEXP '\\d+', null, 'EPISODE_NUMBER_NOT_INTEGER')),
    IFF(GENRE is null OR ARRAY_SIZE(GENRE) <= 1, null, 'GENRE_HAS_MULTIPLE_ITEMS'),
    IFF(DURATION is not null AND ARRAY_SIZE(DURATION) >= 1, null, 'DURATION_REQUIRED'),
    IFF(DURATION is null OR ARRAY_SIZE(DURATION) <= 1, null, 'DURATION_HAS_MULTIPLE_ITEMS'),
    IFF(DURATION[0] is null, null, IFF(DURATION[0]::string REGEXP 'PT((\\d+H)?\\d+M)?\\d+(\.\\d+)?S', null, 'DURATION_NOT_ALLOWED_PATTERN')),
    IFF(LANGUAGE_LOCALIZATION_TYPE is null OR ARRAY_SIZE(LANGUAGE_LOCALIZATION_TYPE) <= 1, null, 'LANGUAGE_LOCALIZATION_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(LANGUAGE_LOCALIZATION_TYPE[0] is null, null, IFF(is_language(LANGUAGE_LOCALIZATION_TYPE[0]::string), null, 'LANGUAGE_LOCALIZATION_TYPE_NOT_ALLOWED_VALUE')),
    IFF(HAS_CAPTIONING is null OR ARRAY_SIZE(HAS_CAPTIONING) <= 1, null, 'HAS_CAPTIONING_HAS_MULTIPLE_ITEMS'),
    IFF(HAS_CAPTIONING[0] is null, null, IFF(RLIKE(HAS_CAPTIONING[0]::string, '(true|false|yes|no|y|n|0|1)', 'i'), null, 'HAS_CAPTIONING_NOT_BOOLEAN')),
    IFF(HAS_AUDIO_DESCRIPTION is null OR ARRAY_SIZE(HAS_AUDIO_DESCRIPTION) <= 1, null, 'HAS_AUDIO_DESCRIPTION_HAS_MULTIPLE_ITEMS'),
    IFF(HAS_AUDIO_DESCRIPTION[0] is null, null, IFF(RLIKE(HAS_AUDIO_DESCRIPTION[0]::string, '(true|false|yes|no|y|n|0|1)', 'i'), null, 'HAS_AUDIO_DESCRIPTION_NOT_BOOLEAN')),
    IFF(LANGUAGE_OF_PERFORMANCE is null OR ARRAY_SIZE(LANGUAGE_OF_PERFORMANCE) <= 1, null, 'LANGUAGE_OF_PERFORMANCE_HAS_MULTIPLE_ITEMS'),
    IFF(LANGUAGE_OF_PERFORMANCE[0] is null, null, IFF(is_language(LANGUAGE_OF_PERFORMANCE[0]::string), null, 'LANGUAGE_OF_PERFORMANCE_NOT_ALLOWED_VALUE')),
    IFF(LANGUAGE_OF_DUBBING is null OR ARRAY_SIZE(LANGUAGE_OF_DUBBING) <= 1, null, 'LANGUAGE_OF_DUBBING_HAS_MULTIPLE_ITEMS'),
    IFF(LANGUAGE_OF_DUBBING[0] is null, null, IFF(is_language(LANGUAGE_OF_DUBBING[0]::string), null, 'LANGUAGE_OF_DUBBING_NOT_ALLOWED_VALUE')),
    IFF(PRODUCTION_OR_RELEASE_DATE is null OR ARRAY_SIZE(PRODUCTION_OR_RELEASE_DATE) <= 1, null, 'PRODUCTION_OR_RELEASE_DATE_HAS_MULTIPLE_ITEMS'),
    IFF(PRODUCTION_OR_RELEASE_DATE[0] is null, null, 
      IFF(TRY_TO_DATE(PRODUCTION_OR_RELEASE_DATE[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(PRODUCTION_OR_RELEASE_DATE[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(PRODUCTION_OR_RELEASE_DATE[0]::string, 'YYYY') is not null, null, 'PRODUCTION_OR_RELEASE_DATE_NOT_DATE'))))
  )
from %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.AS03;


CREATE OR REPLACE VIEW SU03_01_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS SELECT
  ASSET_ID,
  LINE_INDEX,
  'SU03.01',
  ARRAY_CONSTRUCT_COMPACT(
    IFF(RECORD_TYPE is not null AND ARRAY_SIZE(RECORD_TYPE) >= 1, null, 'RECORD_TYPE_REQUIRED'),
    IFF(RECORD_TYPE is null OR ARRAY_SIZE(RECORD_TYPE) <= 1, null, 'RECORD_TYPE_HAS_MULTIPLE_ITEMS'),
    IFF(RECORD_TYPE[0] is null, null, IFF(RECORD_TYPE[0]::string IN ('SU03.01'), null, 'RECORD_TYPE_NOT_ALLOWED_VALUE')),
    IFF(BLOCK_ID is not null AND ARRAY_SIZE(BLOCK_ID) >= 1, null, 'BLOCK_ID_REQUIRED'),
    IFF(BLOCK_ID is null OR ARRAY_SIZE(BLOCK_ID) <= 1, null, 'BLOCK_ID_HAS_MULTIPLE_ITEMS'),
    IFF(SALES_TRANSACTION_ID is not null AND ARRAY_SIZE(SALES_TRANSACTION_ID) >= 1, null, 'SALES_TRANSACTION_ID_REQUIRED'),
    IFF(SALES_TRANSACTION_ID is null OR ARRAY_SIZE(SALES_TRANSACTION_ID) <= 1, null, 'SALES_TRANSACTION_ID_HAS_MULTIPLE_ITEMS'),
    IFF(SUMMARY_RECORD_ID is null OR ARRAY_SIZE(SUMMARY_RECORD_ID) <= 1, null, 'SUMMARY_RECORD_ID_HAS_MULTIPLE_ITEMS'),
    IFF(DSP_RESOURCE_ID is not null AND ARRAY_SIZE(DSP_RESOURCE_ID) >= 1, null, 'DSP_RESOURCE_ID_REQUIRED'),
    IFF(DSP_RESOURCE_ID is null OR ARRAY_SIZE(DSP_RESOURCE_ID) <= 1, null, 'DSP_RESOURCE_ID_HAS_MULTIPLE_ITEMS'),
    IFF(USAGES is not null AND ARRAY_SIZE(USAGES) >= 1, null, 'USAGES_REQUIRED'),
    IFF(USAGES is null OR ARRAY_SIZE(USAGES) <= 1, null, 'USAGES_HAS_MULTIPLE_ITEMS'),
    IFF(USAGES[0] is null, null, IFF(USAGES[0]::string REGEXP '\\d+', null, 'USAGES_NOT_INTEGER')),
    IFF(NET_REVENUE is not null AND ARRAY_SIZE(NET_REVENUE) >= 1, null, 'NET_REVENUE_REQUIRED'),
    IFF(NET_REVENUE is null OR ARRAY_SIZE(NET_REVENUE) <= 1, null, 'NET_REVENUE_HAS_MULTIPLE_ITEMS'),
    IFF(NET_REVENUE[0] is null, null, IFF(NET_REVENUE[0]::string REGEXP '\\d+(\.\\d+)?', null, 'NET_REVENUE_NOT_DECIMAL')),
    IFF(VALIDITY_PERIOD_START is null OR ARRAY_SIZE(VALIDITY_PERIOD_START) <= 1, null, 'VALIDITY_PERIOD_START_HAS_MULTIPLE_ITEMS'),
    IFF(VALIDITY_PERIOD_START[0] is null, null, 
      IFF(TRY_TO_DATE(VALIDITY_PERIOD_START[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(VALIDITY_PERIOD_START[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(VALIDITY_PERIOD_START[0]::string, 'YYYY') is not null, null, 'VALIDITY_PERIOD_START_NOT_DATE')))),
    IFF(VALIDITY_PERIOD_END is null OR ARRAY_SIZE(VALIDITY_PERIOD_END) <= 1, null, 'VALIDITY_PERIOD_END_HAS_MULTIPLE_ITEMS'),
    IFF(VALIDITY_PERIOD_END[0] is null, null, 
      IFF(TRY_TO_DATE(VALIDITY_PERIOD_END[0]::string, 'YYYY-MM-DD') is not null, null, 
      IFF(TRY_TO_DATE(VALIDITY_PERIOD_END[0]::string, 'YYYY-MM') is not null, null, 
      IFF(TRY_TO_DATE(VALIDITY_PERIOD_END[0]::string, 'YYYY') is not null, null, 'VALIDITY_PERIOD_END_NOT_DATE'))))
  )
from %ENV%_DDEX_DSR.UNTYPED_AVP_MRB_10.SU03_01;


CREATE OR REPLACE VIEW RECORD_VALIDATION (
  ASSET_ID,
  LINE_INDEX,
  RECORD_TYPE,
  VIOLATIONS
) AS
SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM HEAD_VALIDATION WHERE ARRAY_SIZE(VIOLATIONS) > 0
UNION
SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM FOOT_VALIDATION WHERE ARRAY_SIZE(VIOLATIONS) > 0
UNION
SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM SY04_01_VALIDATION WHERE ARRAY_SIZE(VIOLATIONS) > 0
UNION
SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM RE03_VALIDATION WHERE ARRAY_SIZE(VIOLATIONS) > 0
UNION
SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM AS03_VALIDATION WHERE ARRAY_SIZE(VIOLATIONS) > 0
UNION
SELECT ASSET_ID, LINE_INDEX, RECORD_TYPE, VIOLATIONS FROM SU03_01_VALIDATION WHERE ARRAY_SIZE(VIOLATIONS) > 0;


