# Learning Notes

These notes explain the AWS Glue + dbt + Snowflake ELT project in a slower, more approachable way than the main README.

The main README is the quick project overview. This folder is for understanding how the pieces fit together:

- what each service does
- how data moves through the pipeline
- why raw, transform, and mart layers exist
- how AWS, Snowflake, and dbt connect
- what the validation steps prove

These notes are written for someone newer to cloud data engineering, a teammate onboarding to the project, or a business reviewer trying to understand the flow without reading every line of code.

## Notes Included

- `end-to-end-walkthrough.md` explains the full project flow from source data to production tables.
- `service-by-service-notes.md` explains the role of each tool.
- `dbt-notes.md` explains the dbt modeling structure.
- `how-to-explain-this-project.md` gives a concise project explanation.

## Project Flow

External JSON source → AWS Glue → S3 → Snowflake → dbt raw layer → dbt transform layer → dbt mart layer → dbt production job
