-- Select Snowflake role and warehouse for setup.
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

-- Create the project database.
CREATE OR REPLACE DATABASE GLUEDB;
USE DATABASE GLUEDB;
USE SCHEMA PUBLIC;

-- Create a Snowflake storage integration.
-- This allows Snowflake to securely read files from an S3 location.
-- Replace the AWS role ARN and S3 bucket URI before running.
CREATE OR REPLACE STORAGE INTEGRATION GLUE_S3_INT
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::<aws-account-id>:role/<snowflake-access-role-name>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://<bucket-name>/data/');

-- Run this to get the Snowflake-generated IAM user ARN and external ID.
-- These values are used to update the AWS IAM role trust policy.
DESC INTEGRATION GLUE_S3_INT;