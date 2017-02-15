#!/usr/bin/env bash

hadoop fs -put -f streamingSumy.py /tmp/reviewSummarizer

scp streamingSumy.py root@hadoop-24:
scp streamingSumy.py root@hadoop-25:
scp streamingSumy.py root@hadoop-26:

scp testData.txt root@hadoop-24:
scp testData.txt root@hadoop-25:
scp testData.txt root@hadoop-26:
