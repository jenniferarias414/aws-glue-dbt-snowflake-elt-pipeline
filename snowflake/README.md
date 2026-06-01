# Snowflake Setup

This folder contains SQL setup scripts used for the Snowflake portion of the AWS Glue + dbt + Snowflake ELT project.

## Purpose

Snowflake acts as the data warehouse for this project.

After AWS Glue writes the JSON source file into S3, Snowflake is configured to securely read from that S3 location. dbt then models the data into raw, transform, and mart layers.

## Snowflake Objects Created

The project uses:

- `GLUEDB` for development
- `GLUEDB_PRODUCTION` for dbt job/deployment validation
- `GLUE_S3_INT` storage integration
- `GLUE_S3_STAGE` external stage
- `COUNTRY_DETAILS_CP` copy table
- `RAW` schema
- `TRANSFORM` schema
- `MART` schema

## Scripts

### `setup_storage_integration.sql`

Creates the Snowflake storage integration that allows Snowflake to access the S3 data folder through an AWS IAM role.

This script also runs:

```sql
DESC INTEGRATION GLUE_S3_INT;
```

The output provides the Snowflake IAM user ARN and external ID needed to update the AWS IAM role trust policy.

### `setup_database_stage.sql`

Creates the Snowflake external stage pointing to the S3 `data/` folder and creates the raw copy table:

```sql
GLUEDB.PUBLIC.COUNTRY_DETAILS_CP
```

The stage is validated with:

```sql
LS @GLUEDB.PUBLIC.GLUE_S3_STAGE;
```

### `production_validation.sql`

Contains validation queries used after the dbt production job runs.

## Development Flow

```text
S3 data/country_details.json
→ Snowflake external stage
→ COUNTRY_DETAILS_CP copy table
→ dbt raw model
→ dbt transform model
→ dbt mart models
```

## Production Flow

The dbt Cloud production job runs against:

```text
GLUEDB_PRODUCTION
```

The production database is validated by checking row counts across the generated Snowflake tables.
