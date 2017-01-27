USE yelp;

DROP FUNCTION IF EXISTS scaleReview;
CREATE FUNCTION scaleReview AS 'edu.rosehulman.rad.ScaleReview' USING JAR 'hdfs:///tmp/jars/RADHiveUDF-0.0.1-SNAPSHOT.jar';

SELECT scale_table.business_id, AVG(scale_table.scale_score) AS scale_rating
FROM (SELECT b.business_id AS business_id, scaleReview(r.rating, cast(r.review_time AS string)) AS scale_score
  FROM BusinessStatic AS b, ReviewStatic AS r
  WHERE b.business_id == r.business_id
    AND r.review_time IS NOT NULL
  ) AS scale_table
WHERE scale_table.scale_score != -1
GROUP BY scale_table.business_id;
