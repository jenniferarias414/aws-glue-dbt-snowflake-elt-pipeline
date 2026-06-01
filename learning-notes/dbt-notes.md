# dbt Notes

This project uses dbt Cloud to create raw, transform, and mart layers in Snowflake.

## What dbt Does in This Project

dbt does not extract the source file from the internet.

dbt does not write the file to S3.

Those steps happen before dbt.

In this project, dbt starts after Snowflake can access the S3 file and the copy table exists.

dbt is responsible for modeling the data inside Snowflake.

## dbt Project Structure

The project-specific dbt files are organized under:

```text
models/glue_snowflake/
```

The portfolio repo stores them under:

```text
dbt/models/glue_snowflake/
```

The folders are:

```text
raw/
transform/
mart/
```

## Raw Layer

The raw model is:

```text
raw_country_details.sql
```

The raw layer reads from the Snowflake copy table:

```text
PUBLIC.COUNTRY_DETAILS_CP
```

It creates:

```text
RAW.RAW_COUNTRY_DETAILS
```

The raw layer still keeps the JSON data mostly intact.

## Transform Layer

The transform model is:

```text
transform_country_details.sql
```

It reads from:

```text
RAW.RAW_COUNTRY_DETAILS
```

It creates:

```text
TRANSFORM.TRANSFORM_COUNTRY_DETAILS
```

This model extracts JSON fields into columns such as:

- country official name
- country common name
- continent
- region
- subregion
- capital
- population
- currency
- language
- driving lane
- UN membership status

## Mart Layer

The mart layer creates separate continent-level tables.

Examples:

```text
MART.COUNTRY_DETAILS_AFRICA
MART.COUNTRY_DETAILS_ASIA
MART.COUNTRY_DETAILS_EUROPE
```

The mart layer reads from the transform model and filters the data by continent.

## Macros

The project uses two dbt macros.

### `copy_into_snowflake.sql`

This macro reloads the staged JSON file into the Snowflake copy table before the raw model runs.

It supports the flow:

```text
S3 external stage
→ Snowflake copy table
→ dbt raw model
```

### `generate_schema_name.sql`

This macro helps dbt create cleaner custom schemas.

Instead of forcing all models into the default schema, dbt can create:

```text
RAW
TRANSFORM
MART
```

## YAML Files

The project uses YAML files to describe models and tests.

Examples:

```text
raw.yml
transform.yml
mart.yml
```

These files help dbt understand:

- model names
- descriptions
- source tables
- column-level documentation
- tests such as not-null and accepted values

## dbt Build

The command used to run dbt models and tests is:

```bash
dbt build
```

`dbt build` can run:

- models
- tests
- snapshots
- seeds

In this project, it was used to build the raw, transform, and mart models and run tests.

## Production Job

The dbt Cloud job ran the project against:

```text
GLUEDB_PRODUCTION
```

This proved that the dbt project could run in a deployment-style environment and create production tables.
