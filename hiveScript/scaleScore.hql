USE yelp;

DROP FUNCTION IF EXISTS scaleReview;
CREATE FUNCTION scaleReview AS 'edu.rosehulman.rad.ScaleReview' USING JAR 'hdfs:///tmp/jars/RADHiveUDF-0.0.1-SNAPSHOT.jar';


CREATE TEMPORARY TABLE IF NOT EXISTS `yelp.temp_review` ( business_id STRING, scaleScore DOUBLE) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;

insert into TABLE `yelp.temp_review` SELECT scale_table.business_id, AVG(scale_table.scale_score) AS scale_rating
FROM (SELECT b.business_id AS business_id, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
  FROM BusinessStatic AS b, ReviewStatic AS r
  WHERE b.business_id == r.business_id
    AND r.review_time IS NOT NULL
  ) AS scale_table
WHERE scale_table.scale_score != -1
GROUP BY scale_table.business_id;

CREATE TEMPORARY TABLE IF NOT EXISTS `yelp.temp_business` ( business_id STRING, name STRING, city STRING, state STRING, scaleScore DOUBLE) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;

-- sort reviews by state, city then top reviews 
insert into TABLE `yelp.temp_business` SELECT b.business_id, b.name, b.city, b.state, r.scaleScore from BusinessStatic as b join  temp_review as r on b.business_id = r.business_id Order by b.state ASC, r.scaleScore DESC;

select scaleReview(rating, cast(review_time as string))
from ReviewStatic
where business_id == 'iHmfkYeEsIxbAqEj3dloQQ'
	and review_time IS NOT NULL;