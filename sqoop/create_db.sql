CREATE TABLE IF NOT EXISTS Business (
  business_id VARCHAR(25) NOT NULL,
  name VARCHAR(70) NOT NULL,
  address VARCHAR(125) NOT NULL,
  longitude DOUBLE NOT NULL,
  latitude DOUBLE NOT NULL,
  rating DECIMAL NOT NULL,
  ratingCount INT NOT NULL,
  state VARCHAR(5),
  city VARCHAR(50),
  PRIMARY KEY (business_id)
);
