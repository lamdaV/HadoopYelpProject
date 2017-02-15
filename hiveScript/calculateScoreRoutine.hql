USE ${databaseName};

CREATE TABLE IF NOT EXISTS PopularityScore(
	business_id string,
	rating int,
	score_time date
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc;

INSERT INTO TABLE PopularityScore
SELECT business_id, greatest(sum(rating), ${min_score}), ${last_month} FROM
	((SELECT business_id, rating-${penalties}
			FROM PopularityScore
			WHERE score_time BETWEEN add_months('${last_month}',-1) AND ${last_month})
		UNION ALL
		(SELECT business_id, sum(rating)*${multiply_bounus} AS rating
				FROM review WHERE review_time BETWEEN  ${last_month} AND add_months('${last_month}', 1))
				GROUP BY business_id) AS tempTable GROUP BY business_id;
