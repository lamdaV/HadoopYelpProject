USE ${databaseName};

DROP TABLE IF EXISTS leaderboard;

CREATE TABLE leaderboard(
	user_id string,
	score int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

SELECT user_id, COUNT(*) as activity
from reviewstatic
where review_time BETWEEN add_months('${current_month}',-1) AND ${current_month}
group by user_id
order by activity DESC limit 50;

insert into TABLE leaderboard
SELECT user_id, COUNT(*) as activity
from reviewstatic
where review_time BETWEEN add_months('${current_month}',-1)
	AND ${current_month}
group by user_id
order by activity DESC limit 50;
