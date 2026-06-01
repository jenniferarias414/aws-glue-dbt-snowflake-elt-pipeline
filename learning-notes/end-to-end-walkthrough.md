# End-to-End Walkthrough

This project built an ELT-style pipeline using AWS Glue, Amazon S3, Snowflake, and dbt Cloud.

The goal was to move country details data from an external JSON source into Snowflake and then model it into raw, transform, and mart layers.

## Big Picture

The pipeline works like this:

External JSON source
→ AWS Glue Python job
→ S3 data folder
→ Snowflake external stage
→ Snowflake copy table
→ dbt raw layer
→ dbt transform layer
→ dbt mart layer
→ dbt production job
→ GLUEDB_PRODUCTION validation

## Step 1: Source Data

The project starts with a public JSON file containing country details.

The file includes nested information such as:

- country names
- continents
- region and subregion
- capital
- population
- currency
- languages
- maps and flags
- UN membership status
- driving lane

Because the source data is JSON, it is semi-structured. That means it does not arrive as a simple flat table.

## Step 2: AWS Glue Extracts the File

AWS Glue runs a Python shell job.

The Glue script fetches the JSON file from the external source and uploads it to Amazon S3.

At this point, AWS Glue is acting as the extraction step.

Input:

External JSON file

Output:

s3://bucket-name/data/country_details.json

## Step 3: S3 Stores the Landed File

Amazon S3 acts as the landing zone.

The Glue job writes the file into the S3 `data/` folder. Snowflake does not receive the file directly from Glue. Instead, Snowflake reads the file from S3 later.

This creates separation between extraction and warehouse loading.

## Step 4: Snowflake Connects to S3

Snowflake needs permission to read from the S3 bucket.

That connection uses:

- AWS IAM role
- Snowflake storage integration
- Snowflake external stage

The external stage is Snowflake's pointer to the S3 folder.

A successful `LS @stage_name` command proves Snowflake can see the file in S3.

## Step 5: Snowflake Copy Table Stores Raw JSON

A Snowflake copy table stores the JSON data in a `VARIANT` column.

The table used in this project is:

GLUEDB.PUBLIC.COUNTRY_DETAILS_CP

This table is the starting point for dbt.

## Step 6: dbt Builds the Raw Layer

The dbt raw model reads from the copy table and creates:

GLUEDB.RAW.RAW_COUNTRY_DETAILS

The raw layer keeps the data close to how it arrived. It still contains semi-structured JSON, but it is now managed as part of the dbt model flow.

## Step 7: dbt Builds the Transform Layer

The transform model reads from the raw layer and extracts nested JSON fields into relational columns.

The transform table is:

GLUEDB.TRANSFORM.TRANSFORM_COUNTRY_DETAILS

This layer makes the data easier to query because fields such as country name, continent, population, and currency become normal columns.

## Step 8: dbt Builds the Mart Layer

The mart layer creates continent-specific tables.

Examples:

- GLUEDB.MART.COUNTRY_DETAILS_AFRICA
- GLUEDB.MART.COUNTRY_DETAILS_ASIA
- GLUEDB.MART.COUNTRY_DETAILS_EUROPE
- GLUEDB.MART.COUNTRY_DETAILS_NORTH_AMERICA

The mart layer represents business-ready outputs. Instead of querying one larger transform table every time, a user or report could query a table already filtered for a specific analysis area.

## Step 9: dbt Production Job Runs the Pipeline

A dbt Cloud job runs `dbt build` against the production database:

GLUEDB_PRODUCTION

The production job validates that the models can run outside the development database and create production raw, transform, and mart outputs.

## Step 10: Validate Production Tables

The final validation checks row counts across the production database.

This confirms that the dbt job created tables and loaded data into the production target.

The project is complete when the production tables exist, have row counts, and a sample mart query returns data.
