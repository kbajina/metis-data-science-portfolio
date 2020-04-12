/* Create Table for Bureau Data */

\connect home_credit_default_risk;

CREATE TABLE bureau(
  SK_ID_CURR INT,
  SK_ID_BUREAU INT,
  CREDIT_ACTIVE VARCHAR,
  CREDIT_CURRENCY VARCHAR,
  DAYS_CREDIT INT,
  CREDIT_DAY_OVERDUE INT,
  DAYS_CREDIT_ENDDATE DECIMAL,
  DAYS_ENDDATE_FACT DECIMAL,
  AMT_CREDIT_MAX_OVERDUE DECIMAL,
  CNT_CREDIT_PROLONG INT,
  AMT_CREDIT_SUM DECIMAL,
  AMT_CREDIT_SUM_DEBT DECIMAL,
  AMT_CREDIT_SUM_LIMIT DECIMAL,
  AMT_CREDIT_SUM_OVERDUE DECIMAL,
  CREDIT_TYPE VARCHAR,
  DAYS_CREDIT_UPDATE INT,
  AMT_ANNUITY DECIMAL
);

/* Import .csv data into this table from local computer */
\COPY bureau FROM '/Users/kbajina/Documents/DATA SCIENCE/Metis | Data Science Bootcamp/Metis Project Portfolio/Metis-Proj-3-classification/data_files/home-credit-default-risk/bureau.csv' DELIMITER ',' CSV HEADER;
