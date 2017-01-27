# Team RAD: Hadoop-Yelp-Project
## Collaborators:
  **R**unzhi Yang, **A**dam Finer, **D**avid Lam

## Feature Goals:
  - [x] Feature 1: We want to reaggregate the business’s review with an emphasis on the most recent reviews.
  - [ ] Feature 2: We want to find the average ratings for all the businesses in each city over a given time interval.
  - [ ] Feature 3: We want to find the highest rated business over a given time interval.
  - [ ] Feature 4: We want to find a leaderboard of active users within a given time interval.
  - [ ] Feature 5: We want, for the above two features, to specify specific features of the types of businesses to be analyzed (like distance from a location, city location, type of business, etc).
  - [ ] Feature 6: We want to summarize large reviews with 500 characters or more with Sumy python library.
  - [ ] Feature 7: We will write a MapReduce job to run a python process to execute Sumy summarizations.

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
    - [x] Begin working with Hive reaggregation of review score.
    - [ ] Partition Tables properly.
  - Adam:
    - [x] Begin working on feature 2: find the average ratings for all the businesses in each city over a given time interval.
  - David:
    - ** Proposed:**
      - [x] Begin working with Hive data to reaggregate review score with weightings.
    - ** Extras:**
      - [x] Reworked logistics of review score reaggregation.
      - [x] Finished UDF for Hive review score reaggregation
      - [x] Updated Pig Scripts to remove rows with any null.

  ### Milestone 03:
    - Runzhi:
      - [ ] Start feature 4: We want to find a leaderboard of active users within a given time interval.
    - Adam:
      - [ ] Finish feature 2: find the average ratings for all the businesses in each city over a given time interval.
      - [ ] Start feature 3: We want to find the highest rated business over a given time interval.
    - David:
      - [ ] Investigate Geo-fencing for Feature 5: We want, for the above two features, to specify specific features of the types of businesses to be analyzed (like distance from a location, city location, type of business, etc).
      - [ ] Start on feature 6: We want to summarize large reviews with 500 characters or more with Sumy python library.
