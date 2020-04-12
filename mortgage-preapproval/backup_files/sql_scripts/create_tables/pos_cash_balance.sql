/* Create Table for pos_cash_balance Data */

\connect home_credit_default_risk;

CREATE TABLE pos_cash_balance(
  SK_ID_PREV INT,
  SK_ID_CURR INT,
  MONTHS_BALANCE INT,
  CNT_INSTALMENT DECIMAL,
  CNT_INSTALMENT_FUTURE DECIMAL,
  NAME_CONTRACT_STATUS VARCHAR,
  SK_DPD INT,
  SK_DPD_DEF INT
);

/* Import .csv data into this table from local computer */
\COPY pos_cash_balance FROM '/Users/kbajina/Documents/DATA SCIENCE/Metis | Data Science Bootcamp/Metis Project Portfolio/Metis-Proj-3-classification/data_files/home-credit-default-risk/pos_cash_balance.csv' DELIMITER ',' CSV HEADER;
