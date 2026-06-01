# Screenshots

This folder stores validation screenshots for the AWS Glue + dbt + Snowflake ELT pipeline.

The full project generated screenshots from setup, execution, validation, and deployment steps.

## Recommended Public Screenshots

For the main README or portfolio case study, the strongest screenshots are:

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

## Screenshot Privacy Notes

Before publishing screenshots publicly, review and blur:

- AWS account IDs
- full IAM role ARNs
- Snowflake usernames
- email addresses
- passwords or credentials
- external IDs
- any sensitive account identifiers

Bucket names, table names, model names, and project resource names are generally acceptable for this temporary learning project, especially after cleanup.
