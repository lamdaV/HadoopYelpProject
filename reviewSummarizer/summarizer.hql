USE yelp;

ADD FILE hdfs:///tmp/reviewSummarizer/streamingSumy.py;

CREATE TABLE IF NOT EXISTS ReviewSummary (
  review_id STRING,
  summary STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

INSERT INTO TABLE 'ReviewSummary'
SELECT TRANSFORM (review)
  USING 'python streamingSumy.py' as (review)
FROM ReviewStatic
WHERE review IS NOT NULL
  AND LENGTH(review) >= 1000;
