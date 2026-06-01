-- Use the project database and schema.
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE GLUEDB;
USE SCHEMA PUBLIC;

-- Create an external stage pointing to the S3 data folder.
-- The stage is Snowflake's reference to the files stored in S3.
CREATE OR REPLACE STAGE GLUEDB.PUBLIC.GLUE_S3_STAGE
  STORAGE_INTEGRATION = GLUE_S3_INT
  URL = 's3://<bucket-name>/data/';

-- Validate Snowflake can see files in S3.
LS @GLUEDB.PUBLIC.GLUE_S3_STAGE;

-- Create a raw copy table for semi-structured JSON data.
CREATE OR REPLACE TABLE GLUEDB.PUBLIC.COUNTRY_DETAILS_CP
(
  DATA VARIANT
);