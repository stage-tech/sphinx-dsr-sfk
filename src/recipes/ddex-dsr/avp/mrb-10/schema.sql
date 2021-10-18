use database %ENV%_DDEX_DSR;

CREATE OR REPLACE SCHEMA UNTYPED_AVP_MRB_10;

CREATE OR REPLACE SCHEMA VALIDATION_AVP_MRB_10;

CREATE OR REPLACE SCHEMA TYPED_AVP_MRB_10;

use schema VALIDATION_AVP_MRB_10;

CREATE OR REPLACE TABLE RECORD_STRUCTURE (
                                                ASSET_ID VARCHAR,
                                                LINE_INDEX INTEGER,
                                                RECORD_TYPE VARCHAR,
                                                BLOCK_ID VARCHAR
);

CREATE OR REPLACE TABLE BLOCK_BOUNDARY (
                                              ASSET_ID VARCHAR,
                                              BLOCK_ID VARCHAR,
                                              START_INDEX INTEGER,
                                              END_INDEX INTEGER
);