USE yelp;

SET hivevar:prev_date = add_months('${hivevar:run_date}', -1);
SET hivevar:prev_year = year(${hivevar:prev_date});
SET hivevar:prev_month = month(${hivevar:prev_date});

SELECT '${hivevar:run_date}';
SELECT ${hivevar:min_score};
SELECT ${hivevar:multiply_bonus};
SELECT ${hivevar:penalties};

SELECT ${hivevar:prev_date};
SELECT ${hivevar:prev_year};
SELECT ${hivevar:prev_month};

CREATE TABLE IF NOT EXISTS PopularityScore (
  business_id String,
  rating double,
  agg_time date
) PARTITIONED BY (
  score_year String,
  score_month String
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

set hive.exec.dynamic.partition.mode=nonstrict;

INSERT INTO TABLE PopularityScore PARTITION(score_year, score_month)
SELECT tempTable.business_id, greatest(sum(tempTable.rating), ${hivevar:min_score}), ${hivevar:prev_date} as agg_time, ${hivevar:prev_year} as score_year, ${hivevar:prev_month} as score_month FROM (
  SELECT business_id, (PopularityScore.rating - ${hivevar:penalties}) as rating
  FROM PopularityScore
  WHERE agg_time BETWEEN add_months('${hivevar:run_date}', -2) AND ${hivevar:prev_date}
  UNION ALL
  SELECT business_id, (sum(review.rating) * ${hivevar:multiply_bonus}) as rating
  FROM Review WHERE review_time BETWEEN ${hivevar:prev_date} AND '${hivevar:run_date}'
  GROUP BY business_id
) AS tempTable
GROUP BY tempTable.business_id;
