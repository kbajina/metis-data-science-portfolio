/* Create Table for Bureau_Balance Data */

\connect home_credit_default_risk;

CREATE TABLE bureau_balance(
  SK_ID_BUREAU INT,
  MONTHS_BALANCE INT,
  STATUS VARCHAR
);

/* Import .csv data into this table from local computer */
\COPY bureau_balance FROM '/Users/kbajina/Documents/DATA SCIENCE/Metis | Data Science Bootcamp/Metis Project Portfolio/Metis-Proj-3-classification/data_files/home-credit-default-risk/bureau_balance.csv' DELIMITER ',' CSV HEADER;
