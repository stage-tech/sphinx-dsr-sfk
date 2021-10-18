use role sysadmin;

create or replace database %ENV%_RAW;

use database %ENV%_RAW;

use role ACCOUNTADMIN;

CREATE OR REPLACE STORAGE INTEGRATION %ENV%_DOOR_%DOOR_ENV%_INBOX_INTEGRATION
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::%AWS_ACCOUNT%:role/snowflake-door-read-role'
  STORAGE_AWS_OBJECT_ACL = 'bucket-owner-full-control'
  STORAGE_ALLOWED_LOCATIONS = ('s3://%DOOR_ENV%-door-inbox-bucket-eu-west-1-%AWS_ACCOUNT%/');

CREATE OR REPLACE STORAGE INTEGRATION %ENV%_DOOR_%DOOR_ENV%_REFERENCE_INTEGRATION
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::%AWS_ACCOUNT%:role/snowflake-door-read-role'
  STORAGE_AWS_OBJECT_ACL = 'bucket-owner-full-control'
  STORAGE_ALLOWED_LOCATIONS = ('s3://%DOOR_ENV%-door-reference-copy-bucket-eu-west-1-%AWS_ACCOUNT%/');

grant usage on integration %ENV%_DOOR_%DOOR_ENV%_INBOX_INTEGRATION to role sysadmin;

grant usage on integration %ENV%_DOOR_%DOOR_ENV%_REFERENCE_INTEGRATION to role sysadmin;

use role SYSADMIN;

create or replace stage DOOR_INBOX_STAGE
storage_integration = %ENV%_DOOR_%DOOR_ENV%_INBOX_INTEGRATION
url = 's3://%DOOR_ENV%-door-inbox-bucket-eu-west-1-%AWS_ACCOUNT%/';

create or replace stage DOOR_REFERENCE_STAGE
storage_integration = %ENV%_DOOR_%DOOR_ENV%_REFERENCE_INTEGRATION
url = 's3://%DOOR_ENV%-door-reference-copy-bucket-eu-west-1-%AWS_ACCOUNT%/';
