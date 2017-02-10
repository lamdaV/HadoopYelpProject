USE yelp;
DROP FUNCTION IF EXISTS reducedScore;

CREATE FUNCTION reducedScore AS 'Reduce' USING JAR 'hdfs:///tmp/jars/CalculateScore-0.0.1.jar';

INSERT INTO TABLE businessdynamicrating
SELECT business_id, reducedScore(sum(rating)), ${current_month_start}
	((SELECT business_id, rating-30
			FROM businessdynamicrating
			WHERE review_stamp BETWEEN ${past_month_start} AND ${current_month_start})
		UNION ALL
		(SELECT business_id, sum(rating)*20 AS rating
				FROM review WHERE review_time BETWEEN  ${current_month_start} AND ${current_month_end})
				GROUP BY business_id) AS tempTable GROUP BY business_id;




-- INSERT INTO TABLE businessdynamicrating
-- SELECT business_id, reducedScore(sum(rating)), cast('2004-11-01' as date)
-- 	FROM (SELECT business_id, rating-30 as rating
-- 			FROM businessdynamicrating
-- 			WHERE review_stamp BETWEEN '2004-10-01' AND '2004-11-01'
-- 		UNION ALL
-- 		SELECT business_id, sum(rating)*20 AS rating
-- 				FROM review WHERE review_time BETWEEN  '2004-11-01' AND '2004-12-01'
-- 				GROUP BY business_id) AS tempTable GROUP BY business_id;