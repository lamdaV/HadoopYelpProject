USE ${databaseName};

SET prev_prev_date = add_months(${run_date},-2);
SET prev_date = add_months(${run_date}, -1);
SET prev_year = cast(year(${prev_date}) AS String);
SET prev_month = cast(month(${prev_date}) AS String);

CREATE TABLE IF NOT EXISTS PopularityScore(
        business_id String,
        rating double,
        agg_time date
    )PARTITIONED BY(
        year String,
        month String
    )
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;

set hive.exec.dynamic.partition.mode=nonstrict;

INSERT INTO TABLE PopularityScore partition(year=${prev_year}, month=${prev_month})
    SELECT tempTable.business_id, greatest(sum(tempTable.rating), ${min_score}), ${prev_date} as agg_time, ${prev_year} as year, ${prev_month} as month FROM
        (SELECT business_id, PopularityScore.rating-${penalties} as rating
                FROM PopularityScore
                WHERE agg_time BETWEEN ${prev_prev_date} AND ${prev_date}
            UNION ALL
            SELECT business_id, sum(review.rating)*${multiply_bounus} as rating
                    FROM review WHERE review_time BETWEEN ${prev_date} AND ${run_date}
                    GROUP BY business_id) AS tempTable
        GROUP BY tempTable.business_id;
