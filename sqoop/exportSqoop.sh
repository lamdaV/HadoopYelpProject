#!/usr/bin/env bash

mysql < setup_mysql.sql
sqoop export --connect jdbc:mysql://$1/yelp --username $2 -m 4 --table Business --export-dir /tmp/pig/nonNullBusiness --input-fields-terminated-by '\t'
sqoop export --connect jdbc:mysql://$1/yelp --username $2 -m 4 --table Review --hcatalog-database yelp --hcatalog-table reviewClean
sqoop export --connect jdbc:mysql://$1/yelp --username $2 -m 4 --table ReviewSummary --hcatalog-database yelp --hcatalog-table reviewSummary
sqoop export --connect jdbc:mysql://$1/yelp --username $2 -m 4 --table Leaderboard --hcatalog-database yelp --hcatalog-table leaderboard
sqoop export --connect jdbc:mysql://$1/yelp --username $2 -m 4 --table ReaggregateScore --hcatalog-database yelp --hcatalog-table WeightedBusinessScore
