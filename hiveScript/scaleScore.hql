USE yelp;

DROP FUNCTION IF EXISTS scaleReview;
CREATE FUNCTION scaleReview AS 'edu.rosehulman.rad.ScaleReview' USING JAR 'hdfs:///tmp/jars/RADHiveUDF-0.0.1-SNAPSHOT.jar';

SELECT b.business_id, scaleReview(r.rating, cast(r.review_time AS string)) AS scaleScore
FROM BusinessStatic AS b, ReviewStatic AS r
WHERE b.business_id == r.business_id
  AND r.review_time IS NOT NULL;
