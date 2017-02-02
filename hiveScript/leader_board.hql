USE yelp;

SELECT user_id, COUNT(*) as activity from reviewstatic 
where review_time BETWEEN ${hiveconf:start_time} AND ${hiveconf:end_time}
group by user_id order by activity DESC limit 50;




