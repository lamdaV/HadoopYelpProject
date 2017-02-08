#!/usr/bin/env bash

sqoop export --connect jdbc:mysql://hadoop-03.csse.rose-hulman.edu:3306/yelp --username root -m 4 --input-null-string __HIVE_DEFAULT_PARTITION__ --table Business --hcatalog-database yelp --hcatalog-table business --hcatalog-partition-keys state,city --hcatalog-partition-values "$1","$2"
