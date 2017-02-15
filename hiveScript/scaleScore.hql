USE ${databaseName};

DROP FUNCTION IF EXISTS scaleReview;
CREATE FUNCTION scaleReview AS 'edu.rosehulman.rad.ScaleReview' USING JAR 'hdfs:///tmp/jars/RADHiveUDF-0.0.1-SNAPSHOT.jar';

DROP TABLE IF EXISTS weighted_business_scores;

CREATE TABLE IF NOT EXISTS WeightedBusinessScore (
	business_id STRING,
	scaleScore DOUBLE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

--select based on dates
insert into TABLE `yelp.WeightedBusinessScore`
SELECT scale_table.business_id, AVG(scale_table.scale_score) AS scale_rating
FROM (
	SELECT b.business_id AS business_id, b.name, b.city, b.state, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
  	FROM Business AS b, ReviewClean AS r
  	WHERE b.business_id == r.business_id
    AND r.review_time IS NOT NULL
    AND r.review_time BETWEEN '2009-01-01' AND ${run_date}
  ) AS scale_table
WHERE scale_table.scale_score != -1 GROUP BY scale_table.business_id
Order by scale_table.state ASC, scale_table.scaleScore DESC;

--select based on full time range
-- INSERT into TABLE WeightedBusinessScore
-- SELECT scale_table.business_id, AVG(scale_table.scale_score) AS scale_rating
-- FROM (SELECT b.business_id AS business_id, b.name as name, b.city AS city, b.state AS state, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
-- 	FROM Business AS b, ReviewClean AS r
--  	WHERE b.business_id == r.business_id
--   	AND r.review_time IS NOT NULL
--    	AND r.review_time BETWEEN '2009-01-01' AND '2017-01-01'
-- ) AS scale_table
-- WHERE scale_table.scale_score != -1
-- GROUP BY scale_table.business_id;
--
-- INSERT INTO TABLE WeightedBusinessScore SELECT scale_table.business_id, AVG(scale_table.scale_score) AS scale_rating FROM ( SELECT b.business_id AS business_id, b.name AS name, b.city AS city, b.state AS state, scaleReview(r.rating, CAST(r.review_time AS STRING)) AS scale_score FROM Business AS b, ReviewClean AS r WHERE b.business_id == r.business_id AND r.review_time IS NOT NULL AND r.review_time BETWEEN '2009-01-01' AND '2017-01-01') AS scale_table WHERE scale_table.scale_score != -1 GROUP BY scale_table.business_id
