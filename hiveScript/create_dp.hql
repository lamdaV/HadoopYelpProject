-- //create a database
-- create database yelp;

-- //switch to a database
use yelp;

--temp table for importing
Create EXTERNAL TABLE BusinessStatic
(
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
LOCALTION '/tmp/pig/';


Create EXTERNAL TABLE reviewstatic(
	reviewId STRING,
	user_id STRING,
	business_id STRING,
	text STRING,
	rating DOUBLE,
	review_time DATE
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
STORED AS TEXTFILE
LOCATION '/tmp/pig/review';


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
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;


Create TABLE review
(
	reviewID STRING,
 	user_id STRING,
 	text STRING,
 	rating DOUBLE,
 	review_time DATE
 ) 
Partitioned by 
(business_id STRING) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
STORED AS orc;

-- set hive.exec.reducers.bytes.per.reducer=800;
-- Set hive.exec.dynamic.partition.mode=nonstrict;

-- insert into TABLE business PARTITION(state, city) SELECT * from businessstatic where business_id DISTRIBUTE BY state, city;

-- insert into TABLE review PARTITION(business_id) SELECT * from reviewstatic DISTRIBUTE BY business_id;



-- Create TABLE Business(business_id STRING, name STRING, address STRING, city STRING, longitude DOUBLE, latitude DOUBLE, rating DOUBLE, ratingCount INT) Partitioned by (state STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;


-- insert into TABLE business PARTITION(state) SELECT * from businessstatic limit 100;


-- Create TABLE review ( reviewID STRING, user_id STRING, text STRING, rating DOUBLE, review_time DATE ) Partitioned by (business_id STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS orc;