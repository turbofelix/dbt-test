{{
    config(
        materialized="incremental",
        on_schema_change="fail",
    )

}}

with stg_reviews as (
    select * from {{ ref('stg_reviews') }}
)

select 
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
*
from stg_reviews
where review_text is not NULL

-- only increment table if date is larger than max date in the current model
{% if is_incremental() %}
    and review_date > (select max(review_date) from {{ this }})
{% endif %}