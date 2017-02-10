USE yelp;

DROP TABLE IF EXISTS leaderboard;

CREATE TABLE leaderboard(
	user_id string,
	score int
)ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

SELECT user_id, COUNT(*) as activity from reviewstatic 
where review_time BETWEEN ${hiveconf:start_time} AND ${hiveconf:end_time}
group by user_id order by activity DESC limit 50;


insert into TABLE leaderboard SELECT user_id, COUNT(*) as activity from reviewstatic where review_time BETWEEN ${hiveconf:start_time} AND ${hiveconf:end_time} group by user_id order by activity DESC limit 50;