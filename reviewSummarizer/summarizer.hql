USE yelp;

ADD FILE hdfs:///tmp/reviewSummarizer/streamingSumy.py;

SELECT TRANSFORM (review)
  USING 'python streamingSumy.py' as (review)
FROM ReviewStatic
WHERE review IS NOT NULL
  AND LENGTH(review);
