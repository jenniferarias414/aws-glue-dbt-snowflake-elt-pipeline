# Screenshot Guide

This project includes screenshots captured while building and validating the AWS Glue + dbt + Snowflake ELT pipeline.

The screenshots are organized into two groups:

```text
screenshots/full-walkthrough/
screenshots/selected-for-readme/
```

## Screenshot Folders

### `screenshots/full-walkthrough/`

This folder contains the full build trail from setup through validation.

It includes screenshots for:

- AWS IAM role setup
- S3 bucket and folder setup
- AWS Glue job configuration and run success
- Snowflake storage integration and stage validation
- dbt raw layer build
- dbt transform layer build
- dbt mart layer build
- dbt production job run
- Snowflake production validation

### `screenshots/selected-for-readme/`

This folder contains the strongest screenshots for a quick project review.

These are the screenshots most useful for the main README, portfolio, or case study.

## Recommended Public Screenshots

| Screenshot | What it proves |
|---|---|
| `09-glue-job-run-success.png` | AWS Glue job ran successfully |
| `10-s3-country-json-output.png` | JSON data landed in S3 |
| `20-snowflake-stage-list-country-json.png` | Snowflake external stage can see the S3 file |
| `33-dbt-build-raw-layer-success.png` | dbt raw layer built successfully |
| `34-snowflake-raw-country-details-validated.png` | Raw table contains data in Snowflake |
| `38-dbt-build-transform-layer-success.png` | dbt transform layer built successfully |
| `39-snowflake-transform-country-details-validated.png` | Transform table contains structured data |
| `46-dbt-build-mart-layer-success.png` | dbt mart layer built successfully |
| `47-snowflake-mart-count-validation.png` | Mart tables contain continent-level row counts |
| `58-dbt-job-run-success.png` | dbt production job ran successfully |
| `59-snowflake-production-table-counts.png` | Production database contains generated tables |
| `60-snowflake-production-mart-sample-data.png` | Production mart table contains queryable data |

## Privacy Review Before Publishing

Before using screenshots publicly, review and blur:

- AWS account IDs
- full IAM role ARNs
- Snowflake usernames
- email addresses
- passwords or credentials
- external IDs
- account identifiers
- anything from unrelated work or private systems

Bucket names, model names, table names, schema names, and temporary learning-project resource names are generally acceptable after resources are cleaned up.