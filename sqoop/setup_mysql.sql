CREATE DATABASE IF NOT EXISTS yelp;

USE yelp;

CREATE TABLE IF NOT EXISTS Business (
  business_id VARCHAR(25) NOT NULL,
  name VARCHAR(70) NOT NULL,
  address VARCHAR(125) NOT NULL,
  city VARCHAR(50),
  state VARCHAR(5),
  longitude DOUBLE NOT NULL,
  latitude DOUBLE NOT NULL,
  rating DECIMAL NOT NULL,
  ratingCount INT NOT NULL,
  PRIMARY KEY (business_id)
);

CREATE TABLE IF NOT EXISTS Review (
  review_id VARCHAR(25) NOT NULL,
  user_id VARCHAR(25) NOT NULL,
  business_id VARCHAR(25) NOT NULL,
  review VARCHAR(5000) NOT NULL,
  rating DECIMAL NOT NULL,
  review_time DATE NOT NULL,
  PRIMARY KEY (review_id),
  FOREIGN KEY (business_id)
    REFERENCES Business(business_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ReviewSummary (
  review_id VARCHAR(25) NOT NULL,
  summary VARCHAR(5100) NOT NULL,
  FOREIGN KEY (review_id)
    REFERENCES Review(review_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Leaderboard (
  user_id VARCHAR(25) NOT NULL,
  score INT NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS ReaggregateScore (
  business_id VARCHAR(25) NOT NULL,
  score DECIMAL NOT NULL,
  FOREIGN KEY (business_id)
    REFERENCES Business(business_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
