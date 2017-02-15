#!/bin/bash

hadoop fs -put -f ./oozie/*.xml ./oozie/job.properties /tmp/deploy/yelp
hadoop fs -put -f ./pigScript/*.pig ./hiveScript/*.hql /tmp/shared/scripts
hadoop fs -put -f ./jars/*.jar /tmp/shared/jars
