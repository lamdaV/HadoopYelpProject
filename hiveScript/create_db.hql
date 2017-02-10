-- //create a database
-- create database yelp;

-- //switch to a database
use yelp;

--temp table for importing
CREATE EXTERNAL TABLE BusinessStatic(
	business_id STRING,
	name STRING,
	address STRING,
	city STRING,
	state STRING,
	longitude DOUBLE,
	latitude DOUBLE,
	rating DOUBLE,
	ratingCount INT
) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/tmp/pig/nonNullBusiness';

CREATE EXTERNAL TABLE ReviewStatic(
	review_id STRING,
	user_id STRING,
	business_id STRING,
	review STRING,
	rating DOUBLE,
	review_time DATE
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/tmp/pig/nonNullReview';


Create TABLE Business
(
	business_id STRING,
	name STRING,
	address STRING,
	longitude DOUBLE,
	latitude DOUBLE,
	rating DOUBLE,
	ratingCount INT
)
Partitioned by
(
	state STRING,
	city STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc;

CREATE TABLE ReviewClean (review_id STRING, user_id STRING, business_id STRING, review STRING, rating DOUBLE, review_time DATE) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;

INSERT INTO ReviewClean SELECT * FROM ReviewStatic where length(review_id) == 22 AND length(user_id) == 22 AND length(business_id) == 22 AND review IS NOT NULL AND rating IS NOT NULL AND review_time IS NOT NULL;


Create TABLE review
(
	review_id STRING,
 	user_id STRING,
 	business_id STRING,
 	review STRING,
 	rating DOUBLE,
 	review_time DATE
 )
Partitioned by
(state STRING,
 city STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc;

set hive.exec.reducers.bytes.per.reducer=1000;
Set hive.exec.dynamic.partition.mode=nonstrict;

insert into TABLE business PARTITION(state, city) SELECT business_id, name, address, longitude, latitude, rating, ratingCount, state, city from businessstatic;

insert into TABLE review PARTITION(state, city) select r.review_id, r.user_id, r.business_id, r.review, r.rating, r.review_time, b.state as state, b.city as city from reviewstatic r join business b on r.business_id = b.business_id order by r.review_time DESC;