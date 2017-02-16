USE ${databaseName};

SET hivevar:prev_date = add_months('${run_date}', -1);
SET hivevar:current_year = DATE_FORMAT('${run_date}', 'yyyy');
SET hivevar:current_month = DATE_FORMAT('${run_date}', 'MM');

CREATE TABLE IF NOT EXISTS ${hivePopularityTable} (
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

INSERT INTO TABLE ${hivePopularityTable} PARTITION(score_year, score_month)
SELECT tempTable.business_id, greatest(sum(tempTable.rating), ${min_score}), ${hivevar:prev_date} as agg_time, ${hivevar:current_year} as score_year, ${hivevar:current_month} as score_month FROM (
  SELECT business_id, (PopularityScore.rating - ${penalties}) as rating
  FROM ${hivePopularityTable} AS PopularityScore
  WHERE agg_time BETWEEN add_months('${run_date}', -2) AND ${hivevar:prev_date}
  UNION ALL
  SELECT business_id, (sum(review.rating) * ${multiply_bonus}) as rating
  FROM Review WHERE review_time BETWEEN ${hivevar:prev_date} AND '${run_date}'
  GROUP BY business_id
) AS tempTable
GROUP BY tempTable.business_id;
