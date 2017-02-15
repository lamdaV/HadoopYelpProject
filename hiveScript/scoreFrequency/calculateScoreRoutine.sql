USE yelp;

INSERT INTO TABLE businessdynamicrating
SELECT business_id, reducedScore(sum(rating)), ${current_month_start}
	((SELECT business_id, rating-30
			FROM businessdynamicrating
			WHERE review_stamp BETWEEN ${past_month_start} AND ${current_month_start})
		UNION ALL
		(SELECT business_id, sum(rating)*20 AS rating
				FROM review WHERE review_time BETWEEN  ${current_month_start} AND ${current_month_end})
				GROUP BY business_id) AS tempTable GROUP BY business_id;
