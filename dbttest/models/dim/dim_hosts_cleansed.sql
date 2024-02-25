{{
    config(
        materialized='view',
    )    
}}


with stg_hosts as (
    select * from {{ ref('stg_hosts') }}
)

select
	host_id,
    coalesce(host_name, 'Anonymous') as host_name,
	-- case
    --     when host_name is not NULL then host_name
    --     else 'Anonymous'
    -- end as host_name
	is_superhost,
    created_at,
    updated_at

from stg_hosts