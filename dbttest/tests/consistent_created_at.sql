select
    r.listing_id,
    review_date,
	created_at
	


from {{ ref('fct_reviews') }} r
left join {{ ref('dim_listings_cleansed' ) }} l
on r.listing_id = l.listing_id

where r.review_date < l.created_at

limit 10
