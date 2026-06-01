# AWS Glue + dbt + Snowflake ELT Pipeline

## Overview

This project demonstrates a guided cloud data engineering pipeline using **AWS Glue**, **Amazon S3**, **Snowflake**, and **dbt Cloud**.

The pipeline extracts country details data from an external JSON source, lands the data in S3, connects Snowflake to the S3 landing location, and uses dbt models to build raw, transform, and mart layers in Snowflake.

This project was completed as part of my data engineering studies and expanded into a portfolio-ready repo with documentation, validation screenshots, and clear project structure.

## Architecture

The end-to-end flow:

```text
External JSON source
→ AWS Glue Python job
→ Amazon S3 landing folder
→ Snowflake storage integration and external stage
→ Snowflake copy table
→ dbt raw layer
→ dbt transform layer
→ dbt mart layer
→ dbt production job
→ GLUEDB_PRODUCTION validation
```

## What This Project Demonstrates

- Extracting JSON data from an external source with AWS Glue
- Writing API/source data into an S3 landing location
- Creating an AWS IAM role for Glue job access
- Creating an AWS IAM role for Snowflake S3 access
- Configuring a Snowflake storage integration and external stage
- Loading semi-structured JSON into Snowflake
- Building dbt models across raw, transform, and mart layers
- Using dbt macros and source configuration
- Creating a dbt deployment environment and job
- Validating production Snowflake tables with row counts

## Tech Stack

- AWS Glue
- Amazon S3
- AWS IAM
- Snowflake
- dbt Cloud
- SQL
- Python
- GitHub

## Data Source

The source data for this guided lab is a JSON file containing country details.

AWS Glue uses a Python shell job to fetch the JSON data from an external raw file URL and upload it to an S3 bucket under the `data/` prefix.

## Repository Structure

```text
.
├── architecture/
│   └── architecture-overview.md
├── dbt/
│   ├── macros/
│   ├── models/
│   │   └── glue_snowflake/
│   │       ├── raw/
│   │       ├── transform/
│   │       └── mart/
│   ├── dbt_project.yml
│   └── README.md
├── docs/
├── glue/
│   ├── glue_job_api_to_s3.py
│   └── README.md
├── learning-notes/
├── screenshots/
├── snowflake/
│   ├── setup_storage_integration.sql
│   ├── setup_database_stage.sql
│   └── README.md
└── README.md
```

## Pipeline Layers

### AWS Glue + S3

AWS Glue runs a Python script that extracts the source JSON file and writes it to an S3 bucket.

This creates the landing zone for Snowflake to read from later.

### Snowflake External Stage

Snowflake connects to the S3 bucket using:

- AWS IAM role
- Snowflake storage integration
- External stage
- Copy table for raw JSON data

### dbt Raw Layer

The raw layer loads and stores the semi-structured country data close to its original JSON shape.

### dbt Transform Layer

The transform layer extracts useful fields from the JSON data into structured columns, including:

- country name
- continent
- region and subregion
- capital
- population
- currency
- language
- maps and flags
- driving lane
- UN membership status

### dbt Mart Layer

The mart layer creates continent-specific reporting tables for:

- Africa
- Antarctica
- Asia
- Europe
- North America
- Oceania
- South America

### dbt Production Job

A dbt Cloud deployment job runs the project against `GLUEDB_PRODUCTION`, creating production raw, transform, and mart tables in Snowflake.

## Validation

The project was validated through:

- Successful AWS Glue job run
- JSON file created in S3
- Snowflake stage listing the S3 file
- dbt raw model build
- dbt transform model build
- dbt mart model build
- dbt production job run
- Snowflake production table row count query

## Notes About Scope

This is a guided learning project and not a production deployment.

For a production implementation, improvements would include:

- Least-privilege IAM policies
- Secrets Manager or parameterized credentials
- Infrastructure as Code
- Automated testing and CI/CD
- Stronger data quality checks
- Monitoring and alerting
- Environment-specific Snowflake roles
- Key-pair or OAuth authentication for dbt/Snowflake

## Project Status

Completed:

- AWS Glue extraction
- S3 landing zone
- Snowflake S3 integration
- dbt raw, transform, and mart models
- dbt production job
- Snowflake validation queries
- GitHub project documentation
