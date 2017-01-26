%default input '/tmp/yelp_dataset/yelp_academic_dataset_business.json'
%default output '/tmp/pig/business'
REGISTER 'hdfs:///tmp/jars/elephant-bird-core-4.1.jar';
REGISTER 'hdfs:///tmp/jars/elephant-bird-hadoop-compat-4.1.jar';
REGISTER 'hdfs:///tmp/jars/elephant-bird-pig-4.1.jar';
REGISTER 'hdfs:///tmp/jars/json-simple-1.1.1.jar';
yelp = LOAD '$input' using com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') as (json:map[]);
desiredData = FOREACH yelp GENERATE
  (chararray) TRIM(json#'business_id') AS businessID,
  (chararray) TRIM(json#'name') AS name,
  REPLACE((chararray) TRIM(json#'full_address'), '\n', ' ') AS address,
  (chararray) TRIM(json#'city') AS city,
  (chararray) TRIM(json#'state') AS state,
  (double) TRIM(json#'longitude') AS longitude,
  (double) TRIM(json#'latitude') AS latitude,
  (double) TRIM(json#'stars') AS rating,
  (int) TRIM(json#'review_count') AS ratingCount;

STORE desiredData into '$output' using PigStorage('\t');
