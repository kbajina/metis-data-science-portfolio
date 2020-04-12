/* File to re-run all scripts for creating final table applications_cleaned */
-- Drop existing version of table in database
DROP TABLE applications_cleaned;

-- Create new version as a copy of applications table
CREATE TABLE applications_cleaned AS TABLE applications;

-- Run all cleanup scripts

\i create_ordinal_dummies.sql

\i update_continuous_var_and_calc_fields.sql

\i drop_unnecessary_fields.sql
