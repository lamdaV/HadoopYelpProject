# Team RAD: Hadoop-Yelp-Project
## Collaborators:
  **R**unzhi Yang, **A**dam Finer, **D**avid Lam

## Feature Goals:
  - [ ] We want to reaggregate the business’s review with an emphasis on the most recent reviews.
  - [ ] We want to find the average ratings for all the businesses in each city over a given time interval.
  - [ ] We want to find the highest rated business over a given time interval.
  - [ ] We want to find a leaderboard of active users within a given time interval.
  - [ ] We want, for the above two features, to specify specific features of the types of businesses to be analyzed (like distance from a location, city location, type of business, etc).
  - [ ] We will use Pig to write specific queries in which the data is refined and limited to specific details.
  - [ ] We want to summarize large reviews with 500 characters or more with Sumy python library.
  - [ ] We will write a MapReduce job to run a python process to execute Sumy summarizations.

## Milestone:
### Milestone 01:
  - Runzhi:
    - [x] Research on how to run query on ~~HBase~~ Hive.
  - Adam:
    - [x] Write a script to move data to cluster and run jobs on cluster without ssh.
  - David:
    - [x] Research and write pig scripts that communicate with ~~HBase~~ Hive.
  - All:
    - [x] Discuss how to accomplish aggregate scoring once data is in cluster.

### Milestone 02:
  - Runzhi:
    - [ ] Begin working with Hive reaggregation of review score.
    - [ ] Partition Tables properly.
  - Adam:
    - [ ] Begin working on feature 2: find the average ratings for all the businesses in each city over a given time interval.
  - David:
    - [ ] Begin working with Hive data to reaggregate review score with weightings.
