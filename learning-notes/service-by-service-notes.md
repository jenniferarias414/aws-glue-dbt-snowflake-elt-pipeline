# Service-by-Service Notes

This project uses AWS Glue, Amazon S3, Snowflake, and dbt Cloud. Each tool has a specific job in the pipeline.

## External JSON Source

The project starts with a JSON file containing country details.

This file represents the external source system for the lab. In a real project, this source could be an API, vendor feed, application export, or operational system.

## AWS Glue

AWS Glue runs the Python extraction job.

In this project, Glue:

- fetches the country details JSON file
- connects to S3 using `boto3`
- writes the JSON file into the S3 `data/` folder

Glue is responsible for getting the source data into the cloud landing area.

## Amazon S3

Amazon S3 stores the extracted JSON file.

In this project, S3 acts as the landing zone between AWS Glue and Snowflake.

The file lands here:

```text
s3://<bucket-name>/data/country_details.json
```

S3 is not transforming the data. It is storing the file so Snowflake can read it.

## AWS IAM

IAM controls permissions between services.

This project uses IAM roles for two main purposes:

1. AWS Glue needs permission to write to S3.
2. Snowflake needs permission to read from S3.

The lab uses broad permissions for speed, but a production setup should use least-privilege access.

## Snowflake

Snowflake is the data warehouse.

In this project, Snowflake:

- connects to S3 through a storage integration
- reads the S3 file through an external stage
- stores the raw JSON in a copy table
- stores the dbt-created raw, transform, and mart tables
- stores the production version of the pipeline outputs

## Snowflake Storage Integration

The storage integration is the secure connection between Snowflake and AWS.

It tells Snowflake which AWS IAM role it can use to access S3.

This is the bridge between:

```text
AWS S3
↔
Snowflake
```

## Snowflake External Stage

The external stage points Snowflake to the S3 folder.

The stage does not copy the data by itself. It tells Snowflake where the files are located.

A successful `LS @stage_name` command proves Snowflake can see the files in S3.

## Snowflake Copy Table

The copy table stores the JSON data in a `VARIANT` column.

In this project:

```text
PUBLIC.COUNTRY_DETAILS_CP
```

This table acts as the handoff point between the S3 file and the dbt modeling layers.

## dbt Cloud

dbt manages the transformation logic.

In this project, dbt creates:

- a raw table
- a transform table
- continent-specific mart tables
- a production job that rebuilds the models in `GLUEDB_PRODUCTION`

dbt is not the extraction tool here. AWS Glue extracts the data. dbt models the data after it is available in Snowflake.

## dbt Raw Layer

The raw layer keeps the source data close to its original form.

It is useful because it preserves the original JSON structure while bringing the data into a dbt-managed model.

## dbt Transform Layer

The transform layer turns nested JSON into structured columns.

This makes the data easier to query and understand.

## dbt Mart Layer

The mart layer creates business-ready tables.

In this project, the mart tables are grouped by continent.

These tables would be easier for reporting or analysis because each table focuses on a specific continent.

## dbt Production Job

The dbt production job runs the project in a deployment environment.

It builds the project into:

```text
GLUEDB_PRODUCTION
```

This proves the pipeline can run as a scheduled or repeatable job, not only as manual development steps.
