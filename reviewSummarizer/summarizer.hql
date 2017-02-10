USE yelp;

ADD FILE hdfs:///tmp/reviewSummarizer/streamingSumy.py;

CREATE TABLE IF NOT EXISTS ReviewSummary (
  review_id STRING,
  summary STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

INSERT INTO TABLE ReviewSummary
SELECT TRANSFORM(review_id, review)
  USING 'python streamingSumy.py' as (review_id STRING, summary STRING)
FROM ReviewClean
WHERE review IS NOT NULL
  AND LENGTH(review) >= 1000;

CREATE TABLE ReviewSummaryClean (
  review_id STRING,
  summary STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

INSERT INTO TABLE ReviewSummaryClean
select ReviewSummary.review_id, ReviewSummary.summary
from ReviewSummary, ReviewClean
where reviewSummary.review_id == reviewClean.review_id;
