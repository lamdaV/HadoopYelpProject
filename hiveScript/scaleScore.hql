USE yelp;

DROP FUNCTION IF EXISTS scaleReview;
CREATE FUNCTION scaleReview AS 'edu.rosehulman.rad.ScaleReview' USING JAR 'hdfs:///tmp/jars/RADHiveUDF-0.0.1-SNAPSHOT.jar';

DROP TABLE IF EXISTS weighted_business_scores;

CREATE TABLE `yelp.weighted_business_scores` (business_id STRING, name STRING, city STRING, state STRING, scaleScore DOUBLE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;

--select based on dates
insert into TABLE `yelp.weighted_business_scores`
SELECT scale_table.business_id, scale_table.name, scale_table.city, scale_table.state, AVG(scale_table.scale_score) AS scale_rating
FROM (
	SELECT b.business_id AS business_id, b.name, b.city, b.state, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
  	FROM BusinessStatic AS b, ReviewStatic AS r
  	WHERE b.business_id == r.business_id
    AND r.review_time IS NOT NULL
    AND r.review_time BETWEEN ${hiveconf:start_time} AND ${hiveconf:end_time}
  ) AS scale_table
WHERE scale_table.scale_score != -1 GROUP BY scale_table.business_id
Order by scale_table.state ASC, scale_table.scaleScore DESC;



-- drop table if exists csv_dump;
-- create table csv_dump ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' LOCATION '/tmp/aggregate' as select * from temp_business;

-- hadoop fs -getmerge /tmp/aggregate/ aggregate.csv





SELECT scale_table.business_id, scale_table.name, scale_table.city, scale_table.state, AVG(scale_table.scale_score) AS scale_rating
 FROM (SELECT b.business_id AS business_id, b.name as name, b.city AS city, b.state AS state, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
   FROM BusinessStatic AS b, ReviewStatic AS r
   WHERE b.business_id == r.business_id
     AND r.review_time IS NOT NULL 
     AND r.review_time BETWEEN '2009-01-01' AND '2017-01-01' limit 1000
   ) AS scale_table
 WHERE scale_table.scale_score != -1
 GROUP BY scale_table.business_id;


 -- -insert into TABLE `yelp.temp_review`
 -- -SELECT scale_table.business_id, AVG(scale_table.scale_score) AS scale_rating
 -- -FROM (SELECT b.business_id AS business_id, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
 -- -  FROM BusinessStatic AS b, ReviewStatic AS r
 -- -  WHERE b.business_id == r.business_id
 -- -    AND r.review_time IS NOT NULL
 -- -  ) AS scale_table
 -- -WHERE scale_table.scale_score != -1
 -- -GROUP BY scale_table.business_id;