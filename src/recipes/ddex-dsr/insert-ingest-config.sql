use schema %ENV%_DDEX_DSR.STAGING;

delete from ingest_config;

insert into ingest_config (SOURCE, SCHEMA_VERSION, SCHEMA, FUNCTION)
values
('spotify_online', 'BasicAudioProfile:1.2', 'UNTYPED_BAP_MRB_12', 'STAGING.DDEX_DSR_PARSER_YOUTUBE'),
('amazon_online', 'BasicAudioProfile:1.1', 'UNTYPED_BAP_MRB_11', 'STAGING.DDEX_DSR_PARSER_AMAZON'),
('amazon_online', 'BasicAudioProfile:1.3', 'UNTYPED_BAP_MRB_13', 'STAGING.DDEX_DSR_PARSER_AMAZON'),
('youtube_online', 'AudioVisualProfile:1.0', 'UNTYPED_AVP_MRB_10', 'STAGING.DDEX_DSR_PARSER_YOUTUBE'),
('tiktok_online', 'BasicAudioProfile:1.2', 'UNTYPED_BAP_MRB_12', 'STAGING.DDEX_DSR_PARSER_YOUTUBE');