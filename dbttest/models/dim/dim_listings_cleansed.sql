{{
    config(
        materialized='view',
    )    
}}

with stg_listings as (
    select * from {{ ref('stg_listings') }}
)

select 
    listing_id,
    listing_name,
    room_type,
    case
        when minimum_nights = 0 then 1
        else minimum_nights
    end as minimum_nights,
    host_id,
    REPLACE(price_str, '$', '')::NUMERIC(10, 2) AS price,
    created_at,
    updated_at
from
    stg_listings