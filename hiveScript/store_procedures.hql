SELECT rating, business_id FROM reviewstatic WHERE 
business_id = p_business AND
`review_time`  BETWEEN p_starting_date AND p_ending_date;

-- CREATE TEMPORARY TABLE IF NOT EXISTS `yelp.temp_review_near` (

-- )


SELECT business_id, AVG(rating) FROM reviewstatic GROUP BY business_id;



 select * from businessstatic where business_id is not NULL and name is not NULL and address is not NULL and city is not NULL and state is not NULL and longitude is not NULL and latitude is not NULL and rating is not NULL and ratingcount is not NULL;