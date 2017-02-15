%default input '/tmp/yelp_dataset/yelp_academic_dataset_review.json'
%default output '/tmp/pig'
REGISTER 'hdfs:///tmp/jars/elephant-bird-core-4.1.jar';
REGISTER 'hdfs:///tmp/jars/elephant-bird-hadoop-compat-4.1.jar';
REGISTER 'hdfs:///tmp/jars/elephant-bird-pig-4.1.jar';
REGISTER 'hdfs:///tmp/jars/json-simple-1.1.1.jar';
yelp = LOAD '$input' using com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') as (json:map[]);
desiredData = FOREACH yelp GENERATE
  (chararray) TRIM(json#'review_id') AS reviewID,
  (chararray) TRIM(json#'user_id') AS userID,
  (chararray) TRIM(json#'business_id') AS businessID,
  REPLACE((chararray) TRIM(json#'text'), '\n', ' ') AS review,
  (double) TRIM(json#'stars') AS rating,
  (chararray) TRIM(json#'date') AS date;

nonNullData = FILTER desiredData BY (reviewID IS NOT NULL AND userID IS NOT NULL AND businessID IS NOT NULL AND review IS NOT NULL AND rating IS NOT NULL AND date IS NOT NULL);

STORE nonNullData into '$output/review/$year-$month' using PigStorage('\t');
