/* Script to modify continuous variables and add calculated fields to
applications_cleaned table */

/* days_birth field */
-- change column values in terms of years instead of days
UPDATE applications_cleaned
SET days_birth = ABS(days_birth::integer/365);

-- change column name to "applicant_age_years"
ALTER TABLE applications_cleaned
RENAME COLUMN days_birth TO applicant_age_years;


/* days_employed field */
-- Some elements in column are 300 000 + days; these need to be set to 0 since
-- all cases only apply to unemployed or pensioners
UPDATE applications_cleaned
SET days_employed = 0
WHERE days_employed > 300000;

-- Update the entire column vales in terms of years instead of days
UPDATE applications_cleaned
SET days_employed = ABS(days_employed::integer/365);

-- change column name to "applicant_age_years"
ALTER TABLE applications_cleaned
RENAME COLUMN days_employed TO applicant_years_employed;


/* days_registration field */
-- change column values to positive; remain in days
UPDATE applications_cleaned
SET days_registration = ABS(days_registration);


/* days_id_publish field */
-- change column values to positive; remain in days
UPDATE applications_cleaned
SET days_id_publish = ABS(days_id_publish);


/* own_car_age field */
-- round column values to full number (age in years)
UPDATE applications_cleaned
SET own_car_age =
  CASE
    WHEN own_car_age IS NULL THEN 0
    ELSE ROUND(own_car_age, 0)
  END
;


/* amt_annuity field */
-- Drop rows with nulls
DELETE FROM applications_cleaned
WHERE amt_annuity IS NULL;


/* amt_goods_price field */
-- Drop rows with nulls
DELETE FROM applications_cleaned
WHERE amt_goods_price IS NULL;


/* applicant's social circle default count */
-- replace all null values with 0
UPDATE applications_cleaned
SET obs_30_cnt_social_circle = 0
WHERE obs_30_cnt_social_circle IS NULL;

UPDATE applications_cleaned
SET def_30_cnt_social_circle = 0
WHERE def_30_cnt_social_circle IS NULL;

UPDATE applications_cleaned
SET obs_60_cnt_social_circle = 0
WHERE obs_60_cnt_social_circle IS NULL;

UPDATE applications_cleaned
SET def_60_cnt_social_circle = 0
WHERE def_60_cnt_social_circle IS NULL;


/* Consolidate total cound of Credit Bureau enquiries into single column */
-- add new column to capture total
ALTER TABLE applications_cleaned
ADD COLUMN credit_bureau_enquiries_past_year integer;

-- update new column by adding all relevant fields (any nulls turned to 0)
UPDATE applications_cleaned
SET credit_bureau_enquiries_past_year =
  CASE
    WHEN amt_req_credit_bureau_hour IS NULL THEN 0
    ELSE amt_req_credit_bureau_hour
  END
  +
  CASE
    WHEN amt_req_credit_bureau_day IS NULL THEN 0
    ELSE amt_req_credit_bureau_day
  END
  +
  CASE
    WHEN amt_req_credit_bureau_week IS NULL THEN 0
    ELSE amt_req_credit_bureau_week
  END
  +
  CASE
    WHEN amt_req_credit_bureau_mon IS NULL THEN 0
    ELSE amt_req_credit_bureau_mon
  END
  +
  CASE
    WHEN amt_req_credit_bureau_qrt IS NULL THEN 0
    ELSE amt_req_credit_bureau_qrt
  END
  +
  CASE
    WHEN amt_req_credit_bureau_year IS NULL THEN 0
    ELSE amt_req_credit_bureau_year
  END
;

-- drop the fields used in the above summation
ALTER TABLE applications_cleaned
DROP COLUMN amt_req_credit_bureau_hour,
DROP COLUMN amt_req_credit_bureau_day,
DROP COLUMN amt_req_credit_bureau_week,
DROP COLUMN amt_req_credit_bureau_mon,
DROP COLUMN amt_req_credit_bureau_qrt,
DROP COLUMN amt_req_credit_bureau_year
;
