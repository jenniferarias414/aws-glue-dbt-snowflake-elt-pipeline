# Project Status

## Status

Completed.

This guided data engineering project was built and validated end-to-end using AWS Glue, Amazon S3, Snowflake, and dbt Cloud.

## Completed Work

### AWS

- Created AWS IAM role for Glue job execution
- Created S3 bucket and data folder
- Created AWS Glue Python shell job
- Ran Glue job successfully
- Validated `country_details.json` landed in S3

### Snowflake

- Created `GLUEDB` development database
- Created Snowflake storage integration for S3 access
- Created external stage pointing to the S3 data folder
- Validated Snowflake could list the S3 JSON file
- Created `COUNTRY_DETAILS_CP` copy table
- Created `GLUEDB_PRODUCTION` database for dbt job validation

### dbt

- Connected dbt Cloud to Snowflake
- Built raw layer model
- Built transform layer model
- Built mart layer models by continent
- Added dbt macros for schema handling and JSON copy logic
- Added YAML documentation and tests
- Created dbt production environment
- Created and ran dbt deployment job
- Validated production Snowflake tables and row counts

## Final Data Flow

External JSON source → AWS Glue Python job → S3 data folder → Snowflake external stage → Snowflake copy table → dbt raw layer → dbt transform layer → dbt mart layer → dbt production job → GLUEDB_PRODUCTION tables

## Validation Evidence

Key validation screenshots include:

- Glue job succeeded
- S3 JSON output created
- Snowflake stage listed the S3 file
- dbt raw build succeeded
- dbt transform build succeeded
- dbt mart build succeeded
- dbt production job succeeded
- Snowflake production tables contained row counts and sample mart data

## Known Notes

The dbt Cloud workspace used for this project was an existing Partner Connect workspace from a prior dbt lab. The project-specific models were organized under `models/glue_snowflake/`.

The clean portfolio repo includes only the files related to this AWS Glue + Snowflake + dbt pipeline.
