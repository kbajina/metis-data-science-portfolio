/* Create Table for installments_payments Data */

\connect home_credit_default_risk;

CREATE TABLE installments_payments(
  SK_ID_PREV INT,
  SK_ID_CURR INT,
  NUM_INSTALMENT_VERSION DECIMAL,
  NUM_INSTALMENT_NUMBER INT,
  DAYS_INSTALMENT DECIMAL,
  DAYS_ENTRY_PAYMENT DECIMAL,
  AMT_INSTALMENT DECIMAL,
  AMT_PAYMENT DECIMAL
);

/* Import .csv data into this table from local computer */
\COPY installments_payments FROM '/Users/kbajina/Documents/DATA SCIENCE/Metis | Data Science Bootcamp/Metis Project Portfolio/Metis-Proj-3-classification/data_files/home-credit-default-risk/installments_payments.csv' DELIMITER ',' CSV HEADER;
