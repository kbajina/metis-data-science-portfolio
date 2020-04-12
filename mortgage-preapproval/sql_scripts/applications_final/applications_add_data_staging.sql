/* Create table to hold bureau data with aggregated stats */
CREATE TABLE bureau_stage AS
SELECT
	sk_id_curr,
	ROUND(
		AVG(
			CASE WHEN credit_day_overdue IS NULL THEN
				0
			ELSE
				credit_day_overdue
			END), 0) AS CB_avg_overdue_days, -- number of days past due across all CB credits
	ROUND(
		MAX(
			CASE WHEN amt_credit_max_overdue IS NULL THEN
				0
			ELSE
				amt_credit_max_overdue
			END), 0) AS CB_avg_max_overdue_credit, -- max overdue amount across all CB credits
	MAX(
		cnt_credit_prolong) AS CB_max_times_credit_prolong -- the most amount of times a CB credit was prolonged
FROM
	bureau
GROUP BY
	sk_id_curr
;

/* Create table to hold bureau ID number with a flag for closed loan statuses */
CREATE TABLE bureau_balance_stage AS
SELECT
	sk_id_bureau,
	bureau_balance.status as CB_loan_status_closed -- refers to Credit Bureau loan status 1 month prior to current application
FROM
	bureau_balance
WHERE
	months_balance = -1
GROUP BY
	sk_id_bureau,
	bureau_balance.status
;

-- Update table to only flag for closed loan status
UPDATE bureau_balance_stage
SET CB_loan_status_closed = 
	CASE
		WHEN CB_loan_status_closed = 'C' THEN 1 
		ELSE 0
	END 
;

/* Mapping table with id_curr to id_bureau - to be used for joining with `bureau_balance_stage` table */
CREATE TABLE sk_id_mapping AS
SELECT
	DISTINCT(sk_id_curr),
	sk_id_bureau
FROM
	bureau
;


CREATE TABLE bureau_balance_stage2 AS
SELECT
	m.sk_id_curr,
	b.sk_id_bureau,
	b.CB_loan_status_closed
FROM
	bureau_balance_stage b
	LEFT JOIN sk_id_mapping m ON b.sk_id_bureau = m.sk_id_bureau;


/* Create final staging table to add additiona data to `applications_cleaned_2` */
CREATE TABLE applications_add_data_staging AS
WITH bb as (
SELECT
	sk_id_curr,
	SUM(cb_loan_status_closed::float)/COUNT(*) as cb_loan_status_close_ratio
FROM bureau_balance_stage2
GROUP BY sk_id_curr
)
SELECT
	b.sk_id_curr,
	b.CB_avg_overdue_days,
	b.CB_avg_max_overdue_credit,
	b.CB_max_times_credit_prolong,
	bb.cb_loan_status_close_ratio
FROM
	bureau_stage b
	LEFT JOIN bb ON b.sk_id_curr = bb.sk_id_curr
;

-- Update table to remove NULLS and round ratio values
UPDATE applications_add_data_staging
SET cb_loan_status_close_ratio = 
	CASE
		WHEN cb_loan_status_close_ratio = 0 THEN 0.00
		WHEN cb_loan_status_close_ratio IS NULL THEN 0.00
		ELSE Round(cb_loan_status_close_ratio::numeric,2)
	END
;

/* Drop unnecessary tables */
DROP TABLE bureau_stage, bureau_balance_stage, bureau_balance_stage2;


/* Join applications_add_data_staging with applications_cleaned_2 */
CREATE TABLE applications_final AS
SELECT
	app.sk_id_curr,
	app.target,
	app.is_male,
	app.flag_own_car,
	app.flag_own_realty,
	app.cnt_children,
	app.amt_income_total,
	app.amt_credit,
	app.amt_annuity,
	app.amt_goods_price,
	app.applicant_age_years,
	app.applicant_years_employed,
	app.days_registration,
	app.days_id_publish,
	app.own_car_age,
	app.flag_mobil,
	app.flag_emp_phone,
	app.flag_work_phone,
	app.flag_cont_mobile,
	app.flag_phone,
	app.flag_email,
	app.cnt_fam_members,
	app.region_rating_client,
	app.hour_appr_process_start,
	app.obs_30_cnt_social_circle,
	app.def_30_cnt_social_circle,
	app.obs_60_cnt_social_circle,
	app.def_60_cnt_social_circle,
	app.cash_loan,
	app.loan_beyond_purchase_price,
	app.applicant_not_working,
	app.applicant_working,
	app.applicant_completed_post_secondary,
	app.applicant_status_married,
	app.applicant_status_widowed,
	app.applicant_owns_house_apt,
	app.applicant_currently_renting,
	app.applicant_living_w_parents,
	app.applicant_occupation_service_ind,
	app.applicant_occupation_working_professional,
	app.credit_bureau_enquiries_past_year,
	app.application_start_date_weekend,
	stage.cb_avg_overdue_days,
	stage.cb_avg_max_overdue_credit,
	stage.cb_max_times_credit_prolong,
	stage.cb_loan_status_close_ratio
FROM
	applications_cleaned_2 app
	LEFT JOIN applications_add_data_staging stage ON app.sk_id_curr = stage.sk_id_curr
;

DROP TABLE applications_add_data_staging;