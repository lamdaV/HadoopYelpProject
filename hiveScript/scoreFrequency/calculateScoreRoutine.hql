USE ${databaseName};

CREATE TABLE IF NOT EXISTS PopularityScore(
	business_id string,
	rating int,
	score_time date
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;

SET prev_prev_month = add_months('${current_month}',-2);
SET prev_month = add_months('${current_month}', -1);

INSERT INTO TABLE PopularityScore
SELECT business_id, greatest(sum(rating), ${min_score}), '${prev_month}' FROM
	((SELECT business_id, rating-${penalties}
			FROM PopularityScore
			WHERE score_time BETWEEN '${prev_prev_month}' AND '${prev_month}')
		UNION ALL
		(SELECT business_id, sum(rating)*${multiply_bounus} AS rating
				FROM review WHERE review_time BETWEEN  '${prev_month}' AND '${current_month}')
				GROUP BY business_id) AS tempTable GROUP BY business_id;

