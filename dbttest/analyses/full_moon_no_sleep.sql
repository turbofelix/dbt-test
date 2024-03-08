-- analyses are queries that are not used in any models
-- but users can still write then with the dbt syntax
-- and execute them with dbt commands

-- use dbt compile to run
-- queries are stored in target folder

with mart_fullmoon_reviews as (

    select * from {{ ref('mart_fullmoon_reviews') }}
)

select 
    is_full_moon,
    review_sentiment,
    count(*) as reviews
from
    mart_fullmoon_reviews
group by
    is_full_moon,
    review_sentiment
order by
    is_full_moon,
    review_sentiment
