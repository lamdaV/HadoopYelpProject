# How To Use:
SCP the newest copy of `streamingSumy.py` if any changes have been made. Use the `updateSummarizer.sh` shell script to upload the file to HDFS. Run the following command:
  ```
    $ hive -f summarizer.hql
  ```

# How To Test:
In order to get this work, I have 500 reviews from the Yelp Review table and stored it as testData.txt. To test this in a non-distributed environment, run the following command:
  ```
    $ cat testData.txt | python streamingSumy.py
  ```

If this is not run on a cluster, I would suggest pushing the results to some output file rather than viewing it in console.
