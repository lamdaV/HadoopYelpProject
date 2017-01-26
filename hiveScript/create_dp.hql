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
LOCALTION '/tmp/pig....';


Create EXTERNAL TABLE reviewstatic
(
	reviewID STRING,
	user_id STRING,
	business_id STRING,
	text STRING,
	rating DOUBLE,
	review_time DATE
) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
STORED AS TEXTFILE
LOCALTION '/tmp/pig....';


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

Set hive.exec.dynamic.partition.mode=nonstrict;

insert into TABLE business PARTITION(state, city) SELECT * from businessstatic DISTRIBUTE BY state, city;

insert into TABLE review PARTITION(business_id) SELECT * from reviewstatic DISTRIBUTE BY business_id;
