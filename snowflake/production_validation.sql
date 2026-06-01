-- Validate production tables created by the dbt deployment job.
-- This query shows table names and row counts across the production database.

SELECT 
    table_schema,
    table_name, 
    row_count
FROM GLUEDB_PRODUCTION.information_schema.tables 
WHERE table_catalog = 'GLUEDB_PRODUCTION'
  AND table_type = 'BASE TABLE'
ORDER BY table_schema, table_name;


-- Sample mart table validation.
-- This confirms that the dbt mart layer created queryable production data.

SELECT *
FROM GLUEDB_PRODUCTION.MART.COUNTRY_DETAILS_AFRICA
LIMIT 20;
