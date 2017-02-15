USE ${databaseName};

CREATE TABLE IF NOT EXISTS PopularityScore(
	business_id String,
	rating int,
	agg_time date
)PARTITIONED BY(
	year String,
	month String
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;

SET prev_prev_month = add_months('${current_month}',-2);
SET prev_month = add_months('${current_month}', -1);
SET year = trunc('${prev_month}', 'YYYY');
SET month = trunc('${prev_month}', 'MM');

INSERT INTO TABLE PopularityScore partition(year, month)
SELECT business_id, greatest(sum(rating), ${min_score}), '${prev_month}', ${year} as year, ${month} as month FROM
	((SELECT business_id, rating-${penalties}
			FROM PopularityScore
			WHERE score_time BETWEEN '${prev_prev_month}' AND '${prev_month}')
		UNION ALL
		(SELECT business_id, sum(rating)*${multiply_bounus} AS rating
				FROM review WHERE review_time BETWEEN '${prev_month}' AND '${current_month}')
				GROUP BY business_id) AS tempTable GROUP BY business_id;

