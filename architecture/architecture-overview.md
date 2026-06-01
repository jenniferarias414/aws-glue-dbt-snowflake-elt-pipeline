# Architecture Overview

## Project Architecture

This project demonstrates an ELT-style data pipeline using AWS Glue, Amazon S3, Snowflake, and dbt Cloud.

## High-Level Flow

External JSON source → AWS Glue → Amazon S3 → Snowflake external stage → Snowflake copy table → dbt raw model → dbt transform model → dbt mart models → dbt production job → production Snowflake tables

## Component Responsibilities

### External JSON Source

The source data is a JSON file containing country details. It represents the external data source used for the guided lab.

### AWS Glue

AWS Glue runs a Python shell job that fetches the JSON file and writes it into S3.

Glue acts as the extraction step.

### Amazon S3

S3 stores the extracted JSON file in a `data/` prefix.

S3 acts as the cloud landing zone between AWS Glue and Snowflake.

### Snowflake Storage Integration

The Snowflake storage integration allows Snowflake to securely access the S3 data folder through an AWS IAM role.

### Snowflake External Stage

The external stage points Snowflake to the S3 location where the JSON file is stored.

### Snowflake Copy Table

The copy table stores the JSON data as semi-structured `VARIANT` data before dbt models it into cleaner layers.

### dbt Raw Layer

The raw layer keeps the data close to its source format and creates a raw table in Snowflake.

### dbt Transform Layer

The transform layer extracts nested JSON fields into structured relational columns.

### dbt Mart Layer

The mart layer creates business-ready continent-specific tables for reporting and analysis.

### dbt Production Job

The production job runs the dbt project against `GLUEDB_PRODUCTION`, creating production raw, transform, and mart tables.

## Layered Model

PUBLIC.COUNTRY_DETAILS_CP → RAW.RAW_COUNTRY_DETAILS → TRANSFORM.TRANSFORM_COUNTRY_DETAILS → MART.COUNTRY_DETAILS_BY_CONTINENT

## Why This Architecture Matters

This project shows how a cloud data pipeline can separate responsibilities across tools:

- AWS Glue handles extraction.
- S3 stores the landed source file.
- Snowflake provides warehouse storage and query capability.
- dbt manages transformation, testing, documentation, and deployment.
