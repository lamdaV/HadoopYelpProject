%default input '/tmp/yelp_dataset/yelp_academic_dataset_review.json'
%default output '/tmp/pig/review'
REGISTER 'hdfs:///tmp/jars/elephant-bird-core-4.1.jar';
REGISTER 'hdfs:///tmp/jars/elephant-bird-hadoop-compat-4.1.jar';
REGISTER 'hdfs:///tmp/jars/elephant-bird-pig-4.1.jar';
REGISTER 'hdfs:///tmp/jars/json-simple-1.1.1.jar';
yelp = LOAD '$input' using com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') as (json:map[]);
desiredData = FOREACH yelp GENERATE
  (chararray) json#'review_id' AS reviewID,
  (chararray) json#'user_id' AS userID,
  (chararray) json#'business_id' AS businessID,
  (chararray) json#'text' AS text,
  (double) json#'stars' AS rating,
  (chararray) json#'date' AS date;
STORE desiredData into '$output' using PigStorage('\t');
