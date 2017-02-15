USE yelp;

SET run_date = '2004-11-01';
SET min_score = 20.0;
SET penalties = 30.0;
SET multiply_bounus = 20.0;
SET prev_prev_date = add_months(${hiveconf:run_date},-2);
SET prev_date = add_months(${hiveconf:run_date}, -1);
SET prev_year = year(${hiveconf:prev_date});
SET prev_month = month(${hiveconf:prev_date});

CREATE TABLE IF NOT EXISTS PopularityScore(
        business_id String,
        rating double,
        agg_time date
    )PARTITIONED BY(
        score_year String,
        score_month String
    )
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;

set hive.exec.dynamic.partition.mode=nonstrict;

INSERT INTO TABLE PopularityScore PARTITION(score_year, score_month)
    SELECT tempTable.business_id, greatest(sum(tempTable.rating), ${hiveconf:min_score}), 
            ${hiveconf:prev_date} as agg_time,${hiveconf:prev_year} as score_year, ${hiveconf:prev_month} as score_month 
        FROM
        (SELECT business_id, PopularityScore.rating-${hiveconf:penalties} as rating
                FROM PopularityScore
                WHERE agg_time BETWEEN ${hiveconf:prev_prev_date} AND ${hiveconf:prev_date}
            UNION ALL
            SELECT business_id, sum(review.rating)*${hiveconf:multiply_bounus} as rating
                    FROM review WHERE review_time BETWEEN ${hiveconf:prev_date} AND ${hiveconf:run_date}
                    GROUP BY business_id) AS tempTable 
        GROUP BY tempTable.business_id;

