USE yelp;

ADD FILE hdfs:///tmp/reviewSummarizer/streamingSumy.py;

SELECT TRANSFORM (text)
  USING 'python streamingSumy.py' as (text string)
FROM ReviewStatic;
