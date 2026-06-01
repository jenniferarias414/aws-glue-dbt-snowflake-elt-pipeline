# Transform Layer

This folder contains the transform model for the AWS Glue + Snowflake + dbt project.

The transform layer reads from the raw country details model and extracts commonly used fields from the semi-structured JSON data.

This layer converts nested JSON fields into relational columns such as:

- country name
- continent
- region and subregion
- capital
- area
- population
- currency
- language
- flag and map links
- driving lane
- UN membership status

Validated with:

```sql
SELECT *
FROM GLUEDB.TRANSFORM.TRANSFORM_COUNTRY_DETAILS;