{{
    config(
        materialized='table',
        schema='MART'
    )
}}

select *
from {{ ref('transform_country_details') }}
where upper(country_continent_name) = 'ANTARCTICA'