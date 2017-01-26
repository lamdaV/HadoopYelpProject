USE yelp;

DROP FUNCTION IF EXISTS scaleReview;
CREATE FUNCTION scaleReview AS 'edu.rosehulman.rad.ScaleReview' USING JAR 'hdfs:///tmp/jars/RADHiveUDF-0.0.1-SNAPSHOT.jar';

SELECT business_id, scaleReview(r.rating, r.review_time)
FROM Business AS b, Review AS r
WHERE b.business_id == r.business_id;
