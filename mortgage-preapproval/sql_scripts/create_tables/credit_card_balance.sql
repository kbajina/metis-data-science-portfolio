/* Create Table for credit_card_balance Data */

\connect home_credit_default_risk;

CREATE TABLE credit_card_balance(
  SK_ID_PREV INT,
  SK_ID_CURR INT,
  MONTHS_BALANCE INT,
  AMT_BALANCE DECIMAL,
  AMT_CREDIT_LIMIT_ACTUAL INT,
  AMT_DRAWINGS_ATM_CURRENT DECIMAL,
  AMT_DRAWINGS_CURRENT DECIMAL,
  AMT_DRAWINGS_OTHER_CURRENT DECIMAL,
  AMT_DRAWINGS_POS_CURRENT DECIMAL,
  AMT_INST_MIN_REGULARITY DECIMAL,
  AMT_PAYMENT_CURRENT DECIMAL,
  AMT_PAYMENT_TOTAL_CURRENT DECIMAL,
  AMT_RECEIVABLE_PRINCIPAL DECIMAL,
  AMT_RECIVABLE DECIMAL,
  AMT_TOTAL_RECEIVABLE DECIMAL,
  CNT_DRAWINGS_ATM_CURRENT DECIMAL,
  CNT_DRAWINGS_CURRENT INT,
  CNT_DRAWINGS_OTHER_CURRENT DECIMAL,
  CNT_DRAWINGS_POS_CURRENT DECIMAL,
  CNT_INSTALMENT_MATURE_CUM DECIMAL,
  NAME_CONTRACT_STATUS VARCHAR,
  SK_DPD INT,
  SK_DPD_DEF INT
);

/* Import .csv data into this table from local computer */
\COPY credit_card_balance FROM '/Users/kbajina/Documents/DATA SCIENCE/Metis | Data Science Bootcamp/Metis Project Portfolio/Metis-Proj-3-classification/data_files/home-credit-default-risk/credit_card_balance.csv' DELIMITER ',' CSV HEADER;
