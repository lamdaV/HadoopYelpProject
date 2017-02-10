-- Min month 2004-10-12
USE yelp;

CREATE TABLE IF NOT EXISTS businessdynamicrating(
	business_id string,
	rating int,
	review_stamp date
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;

INSERT INTO TABLE businessdynamicrating
	SELECT business_id, sum(rating)*10 as rating, cast('2004-10-01' as date)
	FROM review WHERE review_time BETWEEN '2004-10-01' AND '2004-11-01'
	GROUP BY business_id;
