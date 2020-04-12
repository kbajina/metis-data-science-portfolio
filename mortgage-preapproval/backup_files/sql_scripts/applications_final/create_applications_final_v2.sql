/* Final applications table with data joined from pos_cash and 
   credit_card staged tables */
CREATE TABLE applications_final_v2 AS
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
	app.cb_avg_overdue_days,
	app.cb_avg_max_overdue_credit,
	app.cb_max_times_credit_prolong,
	app.cb_loan_status_close_ratio,
	cash.cash_loan_max_future_installments,
	cash.ytd_cash_loan_dpd,
	cc.recent_cc_balance,
	cc.current_cc_limit,
	cc.avg_monthly_change_cc_balance,
	cc.avg_ytd_cc_dpd
FROM
	applications_final app
	LEFT JOIN pos_cash_staged_data cash 
		ON app.sk_id_curr = cash.sk_id_curr
	LEFT JOIN credit_card_staged_data cc 
		ON app.sk_id_curr = cc.sk_id_curr	
;

UPDATE applications_final_v2
-- Replace field null values with zero
SET cb_avg_overdue_days = 
	CASE 
		WHEN cb_avg_overdue_days IS NULL THEN 0 
		ELSE cb_avg_overdue_days
	END 
	,
-- Replace field null values with zero
	cb_avg_max_overdue_credit = 
	CASE 
		WHEN cb_avg_max_overdue_credit IS NULL THEN 0 
		ELSE cb_avg_max_overdue_credit
	END 
	,
-- Replace field null values with zero
	cb_max_times_credit_prolong = 
	CASE 
		WHEN cb_max_times_credit_prolong IS NULL THEN 0 
		ELSE cb_max_times_credit_prolong
	END 
	,
-- Replace field null values with zero
	cb_loan_status_close_ratio = 
	CASE 
		WHEN cb_loan_status_close_ratio IS NULL THEN 0 
		ELSE cb_loan_status_close_ratio
	END 
	,
-- Replace field null values with zero
	cash_loan_max_future_installments = 
	CASE 
		WHEN cash_loan_max_future_installments IS NULL THEN 0 
		ELSE cash_loan_max_future_installments
	END 
	,
-- Replace field null values with zero
	ytd_cash_loan_dpd = 
	CASE 
		WHEN ytd_cash_loan_dpd IS NULL THEN 0 
		ELSE ytd_cash_loan_dpd
	END 
	,
-- Replace field null values with zero
	recent_cc_balance = 
	CASE 
		WHEN recent_cc_balance IS NULL THEN 0 
		ELSE recent_cc_balance
	END 
	,
-- Replace field null values with zero
	current_cc_limit = 
	CASE 
		WHEN current_cc_limit IS NULL THEN 0 
		ELSE current_cc_limit
	END 
	,
-- Replace field null values with zero
	avg_monthly_change_cc_balance = 
	CASE 
		WHEN avg_monthly_change_cc_balance IS NULL THEN 0 
		ELSE avg_monthly_change_cc_balance
	END 
	,
-- Replace field null values with zero
	avg_ytd_cc_dpd = 
	CASE 
		WHEN avg_ytd_cc_dpd IS NULL THEN 0 
		ELSE avg_ytd_cc_dpd
	END 
;

/* Add field to applications_final_v2 that finds ratio of annual annuity to 
   annual income - 43% is the cuttoff according to Dodd-Frank act, where consumer
   has legal protection to claim that they were sold an inappopriate mortgage */
ALTER TABLE applications_final_v2
ADD COLUMN annual_annuity_income_ratio numeric;

UPDATE applications_final_v2
SET annual_annuity_income_ratio = ROUND(amt_annuity / amt_income_total, 2)
;


	
	
	
	