/* Create Table for Application Data: includes only training data file */

\connect home_credit_default_risk;

CREATE TABLE applications(
  SK_ID_CURR INT,
  TARGET INT,
  NAME_CONTRACT_TYPE VARCHAR,
  CODE_GENDER VARCHAR,
  FLAG_OWN_CAR VARCHAR,
  FLAG_OWN_REALTY VARCHAR,
  CNT_CHILDREN INT,
  AMT_INCOME_TOTAL DECIMAL,
  AMT_CREDIT DECIMAL,
  AMT_ANNUITY DECIMAL,
  AMT_GOODS_PRICE DECIMAL,
  NAME_TYPE_SUITE VARCHAR,
  NAME_INCOME_TYPE VARCHAR,
  NAME_EDUCATION_TYPE VARCHAR,
  NAME_FAMILY_STATUS VARCHAR,
  NAME_HOUSING_TYPE VARCHAR,
  REGION_POPULATION_RELATIVE DECIMAL,
  DAYS_BIRTH INT,
  DAYS_EMPLOYED INT,
  DAYS_REGISTRATION DECIMAL,
  DAYS_ID_PUBLISH INT,
  OWN_CAR_AGE DECIMAL,
  FLAG_MOBIL INT,
  FLAG_EMP_PHONE INT,
  FLAG_WORK_PHONE INT,
  FLAG_CONT_MOBILE INT,
  FLAG_PHONE INT,
  FLAG_EMAIL INT,
  OCCUPATION_TYPE VARCHAR,
  CNT_FAM_MEMBERS DECIMAL,
  REGION_RATING_CLIENT INT,
  REGION_RATING_CLIENT_W_CITY INT,
  WEEKDAY_APPR_PROCESS_START VARCHAR,
  HOUR_APPR_PROCESS_START INT,
  REG_REGION_NOT_LIVE_REGION INT,
  REG_REGION_NOT_WORK_REGION INT,
  LIVE_REGION_NOT_WORK_REGION INT,
  REG_CITY_NOT_LIVE_CITY INT,
  REG_CITY_NOT_WORK_CITY INT,
  LIVE_CITY_NOT_WORK_CITY INT,
  ORGANIZATION_TYPE VARCHAR,
  EXT_SOURCE_1 DECIMAL,
  EXT_SOURCE_2 DECIMAL,
  EXT_SOURCE_3 DECIMAL,
  APARTMENTS_AVG DECIMAL,
  BASEMENTAREA_AVG DECIMAL,
  YEARS_BEGINEXPLUATATION_AVG DECIMAL,
  YEARS_BUILD_AVG DECIMAL,
  COMMONAREA_AVG DECIMAL,
  ELEVATORS_AVG DECIMAL,
  ENTRANCES_AVG DECIMAL,
  FLOORSMAX_AVG DECIMAL,
  FLOORSMIN_AVG DECIMAL,
  LANDAREA_AVG DECIMAL,
  LIVINGAPARTMENTS_AVG DECIMAL,
  LIVINGAREA_AVG DECIMAL,
  NONLIVINGAPARTMENTS_AVG DECIMAL,
  NONLIVINGAREA_AVG DECIMAL,
  APARTMENTS_MODE DECIMAL,
  BASEMENTAREA_MODE DECIMAL,
  YEARS_BEGINEXPLUATATION_MODE DECIMAL,
  YEARS_BUILD_MODE DECIMAL,
  COMMONAREA_MODE DECIMAL,
  ELEVATORS_MODE DECIMAL,
  ENTRANCES_MODE DECIMAL,
  FLOORSMAX_MODE DECIMAL,
  FLOORSMIN_MODE DECIMAL,
  LANDAREA_MODE DECIMAL,
  LIVINGAPARTMENTS_MODE DECIMAL,
  LIVINGAREA_MODE DECIMAL,
  NONLIVINGAPARTMENTS_MODE DECIMAL,
  NONLIVINGAREA_MODE DECIMAL,
  APARTMENTS_MEDI DECIMAL,
  BASEMENTAREA_MEDI DECIMAL,
  YEARS_BEGINEXPLUATATION_MEDI DECIMAL,
  YEARS_BUILD_MEDI DECIMAL,
  COMMONAREA_MEDI DECIMAL,
  ELEVATORS_MEDI DECIMAL,
  ENTRANCES_MEDI DECIMAL,
  FLOORSMAX_MEDI DECIMAL,
  FLOORSMIN_MEDI DECIMAL,
  LANDAREA_MEDI DECIMAL,
  LIVINGAPARTMENTS_MEDI DECIMAL,
  LIVINGAREA_MEDI DECIMAL,
  NONLIVINGAPARTMENTS_MEDI DECIMAL,
  NONLIVINGAREA_MEDI DECIMAL,
  FONDKAPREMONT_MODE VARCHAR,
  HOUSETYPE_MODE VARCHAR,
  TOTALAREA_MODE DECIMAL,
  WALLSMATERIAL_MODE VARCHAR,
  EMERGENCYSTATE_MODE VARCHAR,
  OBS_30_CNT_SOCIAL_CIRCLE DECIMAL,
  DEF_30_CNT_SOCIAL_CIRCLE DECIMAL,
  OBS_60_CNT_SOCIAL_CIRCLE DECIMAL,
  DEF_60_CNT_SOCIAL_CIRCLE DECIMAL,
  DAYS_LAST_PHONE_CHANGE DECIMAL,
  FLAG_DOCUMENT_2 INT,
  FLAG_DOCUMENT_3 INT,
  FLAG_DOCUMENT_4 INT,
  FLAG_DOCUMENT_5 INT,
  FLAG_DOCUMENT_6 INT,
  FLAG_DOCUMENT_7 INT,
  FLAG_DOCUMENT_8 INT,
  FLAG_DOCUMENT_9 INT,
  FLAG_DOCUMENT_10 INT,
  FLAG_DOCUMENT_11 INT,
  FLAG_DOCUMENT_12 INT,
  FLAG_DOCUMENT_13 INT,
  FLAG_DOCUMENT_14 INT,
  FLAG_DOCUMENT_15 INT,
  FLAG_DOCUMENT_16 INT,
  FLAG_DOCUMENT_17 INT,
  FLAG_DOCUMENT_18 INT,
  FLAG_DOCUMENT_19 INT,
  FLAG_DOCUMENT_20 INT,
  FLAG_DOCUMENT_21 INT,
  AMT_REQ_CREDIT_BUREAU_HOUR DECIMAL,
  AMT_REQ_CREDIT_BUREAU_DAY DECIMAL,
  AMT_REQ_CREDIT_BUREAU_WEEK DECIMAL,
  AMT_REQ_CREDIT_BUREAU_MON DECIMAL,
  AMT_REQ_CREDIT_BUREAU_QRT DECIMAL,
  AMT_REQ_CREDIT_BUREAU_YEAR DECIMAL
);

/* Import .csv data into this table from local computer */
\COPY applications FROM '/Users/kbajina/Documents/DATA SCIENCE/Metis | Data Science Bootcamp/Metis Project Portfolio/Metis-Proj-3-classification/data_files/home-credit-default-risk/application_train.csv' DELIMITER ',' CSV HEADER;
