#!/bin/bash
hadoop fs -put -f job.properties *.xml lib /tmp/deploy/yelp
hadoop fs -put -f *.pig  *.hql /tmp/shared/scripts
