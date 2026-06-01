# Raw Layer

This folder contains the raw dbt model for the AWS Glue + Snowflake + dbt project.

The raw layer loads semi-structured country data from the Snowflake copy table into a dedicated `RAW` schema.

Flow for this layer:

1. AWS Glue extracts `country_details.json` from the source URL and writes it to S3.
2. Snowflake reads the S3 file through the external stage `GLUE_S3_STAGE`.
3. The `copy_json` macro reloads the staged JSON into `GLUEDB.PUBLIC.COUNTRY_DETAILS_CP`.
4. The `raw_country_details` model flattens the JSON and creates the raw table in Snowflake.

Validated with:

```sql
SELECT *
FROM GLUEDB.RAW.RAW_COUNTRY_DETAILS;