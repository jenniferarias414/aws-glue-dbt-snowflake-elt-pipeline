# dbt Models

This folder contains the dbt portion of the AWS Glue + Snowflake ELT pipeline.

The dbt models transform semi-structured country JSON data into raw, transform, and mart tables in Snowflake.

## dbt Flow

```text
Snowflake copy table
→ dbt raw model
→ dbt transform model
→ dbt mart models
→ dbt production job
```

## Folder Structure

```text
dbt/
├── macros/
│   ├── copy_into_snowflake.sql
│   └── generate_schema_name.sql
├── models/
│   └── glue_snowflake/
│       ├── raw/
│       ├── transform/
│       └── mart/
└── dbt_project.yml
```

## Macros

### `copy_into_snowflake.sql`

Reloads the staged JSON file into the Snowflake copy table before the raw model runs.

This supports the flow:

```text
S3 stage
→ Snowflake copy table
→ dbt raw layer
```

### `generate_schema_name.sql`

Allows dbt to create clean schema names such as:

```text
RAW
TRANSFORM
MART
```

## Raw Layer

The raw layer keeps the source data close to its original JSON structure.

Main model:

```text
raw_country_details.sql
```

Output:

```text
GLUEDB.RAW.RAW_COUNTRY_DETAILS
```

## Transform Layer

The transform layer extracts nested JSON fields into structured columns.

Main model:

```text
transform_country_details.sql
```

Output:

```text
GLUEDB.TRANSFORM.TRANSFORM_COUNTRY_DETAILS
```

Examples of transformed fields:

- country name
- continent
- region
- capital
- population
- currency
- language
- maps and flags

## Mart Layer

The mart layer creates continent-specific tables for easier reporting and analysis.

Mart tables:

- `COUNTRY_DETAILS_AFRICA`
- `COUNTRY_DETAILS_ANTARCTICA`
- `COUNTRY_DETAILS_ASIA`
- `COUNTRY_DETAILS_EUROPE`
- `COUNTRY_DETAILS_NORTH_AMERICA`
- `COUNTRY_DETAILS_OCEANIA`
- `COUNTRY_DETAILS_SOUTH_AMERICA`

## Validation

The dbt models were validated by running:

```bash
dbt build
```

The final deployment job ran successfully in dbt Cloud and created production tables in:

```text
GLUEDB_PRODUCTION
```

## Note About dbt Cloud Workspace

This project used an existing dbt Cloud Partner Connect workspace. The project-specific models were organized under:

```text
models/glue_snowflake/
```

The clean portfolio repo includes only the files related to this AWS Glue + Snowflake + dbt pipeline.
