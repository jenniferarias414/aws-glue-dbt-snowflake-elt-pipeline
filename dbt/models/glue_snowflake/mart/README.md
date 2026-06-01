# Mart Layer

This folder contains the mart models for the AWS Glue + Snowflake + dbt project.

The mart layer reads from the transform model and creates business-ready tables grouped by continent.

Each mart table filters the transformed country details data into a specific continent:

- Africa
- Antarctica
- Asia
- Europe
- North America
- Oceania
- South America

The purpose of this layer is to show how transformed data can be shaped into smaller, easier-to-consume tables for reporting or analysis.

Validated with queries such as:

```sql
SELECT *
FROM GLUEDB.MART.COUNTRY_DETAILS_AFRICA;