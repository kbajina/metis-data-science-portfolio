/* Script to create dummy variables and ordinal feature values for
applications_cleaned table */

/* code_gender field */
-- remove null values
DELETE FROM applications_cleaned
WHERE code_gender='XNA'
;

-- change column values to binary values
UPDATE applications_cleaned
SET code_gender =
  CASE
    WHEN code_gender = 'M' THEN 1
    ELSE 0
  END
;

-- change column name to flag "male"
ALTER TABLE applications_cleaned
RENAME COLUMN code_gender TO is_male
;

-- change column data type to integer
ALTER TABLE applications_cleaned
ALTER COLUMN is_male TYPE integer USING (is_male::integer)
;


/* name_contract_type field */
-- flag if application is for cash loan
ALTER TABLE applications_cleaned
ADD COLUMN cash_loan integer
;

UPDATE applications_cleaned
SET cash_loan =
  CASE
    WHEN name_contract_type = 'Cash loans' THEN 1
    ELSE 0
  END
;

-- revolving loans will be the base case
ALTER TABLE applications_cleaned
DROP COLUMN name_contract_type
;


/* flag_own_car field */
-- change column values to binary values
UPDATE applications_cleaned
SET flag_own_car =
  CASE
    WHEN flag_own_car = 'Y' THEN 1
    ELSE 0
  END
;

-- change column data type to integer
ALTER TABLE applications_cleaned
ALTER COLUMN flag_own_car TYPE integer USING (flag_own_car::integer)
;


/* flag_own_realty field */
-- change column values to binary values
UPDATE applications_cleaned
SET flag_own_realty =
  CASE
    WHEN flag_own_realty = 'Y' THEN 1
    ELSE 0
  END
;

-- change column data type to integer
ALTER TABLE applications_cleaned
ALTER COLUMN flag_own_realty TYPE integer USING (flag_own_realty::integer)
;


/* create new field loan_beyond_purchase_price - to calculate the difference
   between loan amount and purchase price of the goods */
-- define new column with data type
ALTER TABLE applications_cleaned
ADD COLUMN loan_beyond_purchase_price numeric
;

-- calculate values for this new field
UPDATE applications_cleaned
SET loan_beyond_purchase_price = amt_credit - amt_goods_price
;


/* drop field name_type_suite - during EDA no relevant trend in this feature */
ALTER TABLE applications_cleaned
DROP COLUMN name_type_suite
;


/* create dummy variables from name_income_type field */
-- Not Working flag (maternity leave, student, unemployed)
ALTER TABLE applications_cleaned
ADD COLUMN applicant_not_working integer
;

UPDATE applications_cleaned
SET applicant_not_working =
  CASE
    WHEN name_income_type = 'Maternity leave' THEN 1
    WHEN name_income_type = 'Student' THEN 1
    WHEN name_income_type = 'Unemplyed' THEN 1
    ELSE 0
  END
;

-- Working job flag
ALTER TABLE applications_cleaned
ADD COLUMN applicant_working integer
;

UPDATE applications_cleaned
SET applicant_working =
  CASE
    WHEN name_income_type = 'Businessman' THEN 1
    WHEN name_income_type = 'Commerical associate' THEN 1
    WHEN name_income_type = 'State servant' THEN 1
    WHEN name_income_type = 'Working' THEN 1
    ELSE 0
  END
;

-- Retirement is the BASE pos_cash_balance

-- Drop name_income_type field since dummy variables have been created
ALTER TABLE applications_cleaned
DROP COLUMN name_income_type
;


/* create dummy variables from name_education_type field */
-- Flag for completed post secondary education
ALTER TABLE applications_cleaned
ADD COLUMN applicant_completed_post_secondary integer
;

UPDATE applications_cleaned
SET applicant_completed_post_secondary =
  CASE
    WHEN name_education_type = 'Academic degree' THEN 1
    WHEN name_education_type = 'Higher education' THEN 1
    ELSE 0
  END
;

-- non post secondary degree applicant is the BASE CASE
ALTER TABLE applications_cleaned
DROP COLUMN name_education_type
;


/* create dummy variables from name_family_status */
-- Flag for applicants who are married
ALTER TABLE applications_cleaned
ADD COLUMN applicant_status_married integer
;

UPDATE applications_cleaned
SET applicant_status_married =
  CASE
    WHEN name_family_status = 'Civil marriage' THEN 1
    WHEN name_family_status = 'Married' THEN 1
    ELSE 0
  END
;

-- Flag for widowed applicants
ALTER TABLE applications_cleaned
ADD COLUMN applicant_status_widowed integer
;

UPDATE applications_cleaned
SET applicant_status_widowed =
  CASE
    WHEN name_family_status = 'Widow' THEN 1
    ELSE 0
  END
;

-- non married applicants are the BASE CASE
ALTER TABLE applications_cleaned
DROP COLUMN name_family_status
;


/* create dummy variables for applicant's current housing status
   based on the field name_housing_type */
-- Flag for applicants who currently own a house or apartment
ALTER TABLE applications_cleaned
ADD COLUMN applicant_owns_house_apt integer
;

UPDATE applications_cleaned
SET applicant_owns_house_apt =
  CASE
    WHEN name_housing_type = 'House / apartment' THEN 1
    ELSE 0
  END
;

-- Flag for applicants who are currently renting an apartment
ALTER TABLE applications_cleaned
ADD COLUMN applicant_currently_renting integer
;

UPDATE applications_cleaned
SET applicant_currently_renting =
  CASE
    WHEN name_housing_type = 'Rented apartment' THEN 1
    ELSE 0
  END
;

-- Flag for applicants who are living with parents
ALTER TABLE applications_cleaned
ADD COLUMN applicant_living_w_parents integer
;

UPDATE applications_cleaned
SET applicant_living_w_parents =
  CASE
    WHEN name_housing_type = 'With parents' THEN 1
    ELSE 0
  END
;

-- All other statuses (coop, municipal or office apartment) are the BASE CASE
ALTER TABLE applications_cleaned
DROP COLUMN name_housing_type
;


/* create dummy variables for applicant's current occupation type */
-- Flag for applicants who work in the service industry
ALTER TABLE applications_cleaned
ADD COLUMN applicant_occupation_service_ind integer;

UPDATE applications_cleaned
SET applicant_occupation_service_ind =
  CASE
    WHEN occupation_type = 'Cleaning staff' THEN 1
    WHEN occupation_type = 'Cooking staff' THEN 1
    WHEN occupation_type = 'Core staff' THEN 1
    WHEN occupation_type = 'Drivers' THEN 1
    WHEN occupation_type = 'Security staff' THEN 1
    WHEN occupation_type = 'Waiters/barmen staff' THEN 1
    ELSE 0
  END
;

-- Flag for applicants who are working professionals
ALTER TABLE applications_cleaned
ADD COLUMN applicant_occupation_working_professional integer
;

UPDATE applications_cleaned
SET applicant_occupation_working_professional =
  CASE
    WHEN occupation_type = 'Accountants' THEN 1
    WHEN occupation_type = 'HR staff' THEN 1
    WHEN occupation_type = 'High skill tech staff' THEN 1
    WHEN occupation_type = 'IT staff' THEN 1
    WHEN occupation_type = 'Managers' THEN 1
    WHEN occupation_type = 'Medicine staff' THEN 1
    WHEN occupation_type = 'Private service staff' THEN 1
    WHEN occupation_type = 'Realty agents' THEN 1
    WHEN occupation_type = 'Sales staff' THEN 1
    WHEN occupation_type = 'Secretaries' THEN 1
    ELSE 0
  END
;

-- All applicants that are Laborers are the BASE CASE
ALTER TABLE applications_cleaned
DROP COLUMN occupation_type
;

/* Update region_rating_client field to include score of rating with city */
-- Update by adding both field values together (for combined score)
UPDATE applications_cleaned
SET region_rating_client = region_rating_client + region_rating_client_w_city
;

-- drop field with city rating
ALTER TABLE applications_cleaned
DROP COLUMN region_rating_client_w_city
;


/* weekday_appr_process_start field */
-- Create falg for weekend application start date
ALTER TABLE applications_cleaned
ADD COLUMN application_start_date_weekend integer
;

UPDATE applications_cleaned
SET application_start_date_weekend =
  CASE
    WHEN weekday_appr_process_start = 'SATURDAY' THEN 1
    WHEN weekday_appr_process_start = 'SUNDAY' THEN 1
    ELSE 0
  END
;

-- drop field weekday_appr_process_start; weekdays are the BASE CASE
ALTER TABLE applications_cleaned
DROP COLUMN weekday_appr_process_start
;
