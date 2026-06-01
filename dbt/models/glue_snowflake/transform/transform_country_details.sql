{{
    config(
        materialized='table',
        schema='TRANSFORM'
    )
}}

with country_details_transform as (

    select
        source_data:name:official::varchar as country_official_name,
        source_data:name:common::varchar as country_common_name,
        source_data:latlng::varchar as country_latlng,
        continent.value::varchar as country_continent_name,
        source_data:region::varchar as country_region_name,
        source_data:subregion::varchar as country_subregion_name,
        source_data:capital::varchar as country_capital_name,
        source_data:capitalInfo:latlng::varchar as country_capital_latlng,
        source_data:area::int as country_total_area,
        source_data:population::int as country_population,
        currency.key::varchar as country_currency,
        currency.value:name::varchar as country_currency_name,
        currency.value:symbol::varchar as country_currency_symbol,
        source_data:flags:png::varchar as country_flag,
        source_data:maps:googleMaps::varchar as country_map,
        source_data:languages::varchar as country_language,
        source_data:startOfWeek::varchar as country_start_of_week,
        source_data:unMember::boolean as country_un_member_status,
        source_data:car:side::varchar as country_driving_lane,
        current_timestamp(6) as insert_dts

    from {{ ref('raw_country_details') }} as raw,
        lateral flatten(raw.source_data:continents) as continent,
        lateral flatten(raw.source_data:currencies) as currency

)

select
    country_official_name,
    country_common_name,
    country_latlng,
    country_continent_name,
    country_region_name,
    country_subregion_name,
    country_capital_name,
    country_capital_latlng,
    country_total_area,
    country_population,
    country_currency,
    country_currency_name,
    country_currency_symbol,
    country_flag,
    country_map,
    country_language,
    country_start_of_week,
    country_un_member_status,
    country_driving_lane,
    insert_dts
from country_details_transform