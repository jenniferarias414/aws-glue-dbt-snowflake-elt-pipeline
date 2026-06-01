# Troubleshooting Notes

This document captures issues encountered while completing the AWS Glue + dbt + Snowflake ELT project.

## dbt Cloud Opened an Existing Project

### Issue

dbt Cloud opened an existing Partner Connect project instead of a brand-new empty project.

### Cause

The dbt Cloud trial/workspace had been used before, so the existing `dbt-data-projects` repo and older folders were still present.

### Resolution

The project-specific dbt files were organized under `models/glue_snowflake/`.

The clean portfolio repo only includes the files related to this project.

## dbt Connection Failed

### Issue

dbt failed to connect to Snowflake with an incorrect username/password error.

### Cause

The existing dbt Cloud credentials were outdated or not using the current Snowflake password.

### Resolution

Updated the dbt Cloud Snowflake credentials and verified the connection to:

- Database: GLUEDB
- Warehouse: COMPUTE_WH
- Schema: PUBLIC
- Role: ACCOUNTADMIN

## Deprecated dbt Test Syntax

### Issue

The mart layer build failed with deprecated `accepted_values` test syntax.

### Cause

The dbt Fusion preview version expected test arguments under the `arguments:` property.

### Resolution

Updated tests from the older top-level `values` format to the newer `arguments.values` format.

Old format:

- accepted_values:
    values: ['Africa']

New format:

- accepted_values:
    arguments:
      values: ['Africa']

## Existing dbt Models Ran During Production Job

### Issue

The dbt production job also processed older models from the existing dbt workspace.

### Cause

The job command was `dbt build`, which runs all models in the connected dbt project.

### Resolution

The job still succeeded and the project-specific production objects were created successfully.

For a cleaner future run, the job command could be narrowed to:

dbt build --select +models/glue_snowflake

## Production Environment Default Schema

### Issue

The dbt Production environment showed a default schema such as `analytics`.

### Cause

The existing dbt Cloud environment already had a default schema configured.

### Resolution

The project models explicitly define custom schemas:

- RAW
- TRANSFORM
- MART

So the default schema did not block this project. The project-specific production tables were successfully created in `GLUEDB_PRODUCTION`.

## Production Database Copy Table

### Issue to Watch

The production dbt job needs the copy table available in the production database.

### Resolution

Created the production copy table:

CREATE OR REPLACE TABLE GLUEDB_PRODUCTION.PUBLIC.COUNTRY_DETAILS_CP
(
    DATA VARIANT
);

This allowed the copy macro and raw model to run in the production target database.
