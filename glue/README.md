# AWS Glue Extraction Job

This folder contains the AWS Glue Python script used for the extraction step of the project.

## Purpose

AWS Glue pulls a JSON file from an external source and writes it to an Amazon S3 bucket.

This creates the landing file that Snowflake reads through an external stage.

## Flow

```text
External JSON file
→ AWS Glue Python shell job
→ S3 data/ prefix
→ Snowflake external stage
```

## Script

```text
glue_job_api_to_s3.py
```

The script:

1. Fetches the source JSON file from a public raw URL.
2. Connects to Amazon S3 using `boto3`.
3. Writes the JSON file to the project S3 bucket.
4. Stores the file under the `data/` prefix as `country_details.json`.

## IAM Role

The Glue job uses an AWS IAM role that allows it to:

- run as an AWS Glue service role
- write data to S3
- write logs to CloudWatch

For this guided lab, AWS managed policies were used for speed. In a production environment, the role should follow least-privilege access and only allow the exact S3 bucket/prefix and log actions required.

## Output

Expected S3 output:

```text
s3://<bucket-name>/data/country_details.json
```

This file becomes the source file for Snowflake and dbt modeling.
