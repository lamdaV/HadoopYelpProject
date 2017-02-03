use yelp;

SELECT b.name as name, r.rating as rating FROM
business b JOIN
(SELECT business_id, avg(scaleReview(rating, cast(review_time AS string))) as rating
FROM reviewstatic WHERE
review_time >= '{hiveconf:startdate}' AND
review_time <= '{hiveconf:enddate}' AND
GROUP BY business_id) r
ON (r.business_id == b.business_id)
ORDER BY rating DESC LIMIT 100;
