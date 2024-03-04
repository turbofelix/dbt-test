{{
    config(
        materialized="table",
    )
}}

with fct_reviews as (
    select * from {{ ref('fct_reviews') }}
),

full_moon_dates as (
    select * from {{ ref('seed_full_moon_dates') }}
)

select
    r.*,
    case
        when fm.full_moon_date is Null then 'not full moon'
        else 'full moon'
    end as is_full_moon
from fct_reviews as r
left join full_moon_dates as fm
on r.review_date = fm.full_moon_date + make_interval(days => 1)