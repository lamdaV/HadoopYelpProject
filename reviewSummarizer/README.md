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

If this does not run on a cluster, I would suggest pushing the results to some output file rather than viewing it in console.

# Tips for Debugging in the Future:
Since Hadoop (at least to my knowledge) does not easily display the exception that occurred if a Python script fails, I surrounded my entire functional workflow of my script in a try-except block. The except block's purpose was to catch **ALL** exceptions and printing out the exception message. That way, if an exception occured, I could then easily see the exception method by performing a simple `select...transform` statement in HIVE.

# Notes:
The `nltk` library that `sumy` relies on expects the `nltk_data` at very specific locations (See [here](http://www.nltk.org/api/nltk.html)).
