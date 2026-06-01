{{
    config(
        materialized='table',
        pre_hook=copy_json('COUNTRY_DETAILS_CP'),
        schema='RAW'
    )
}}

with country_details_raw as (

    select
        x.value as source_data,
        current_timestamp(6) as insert_dts
    from {{ source('country', 'COUNTRY_DETAILS_CP') }} as a,
    lateral flatten(a.data) as x

)

select
    cast(source_data as variant) as source_data,
    cast(insert_dts as timestamp(6)) as insert_dts
from country_details_raw