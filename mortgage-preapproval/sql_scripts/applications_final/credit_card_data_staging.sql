/* Staged data from credit_card_balance - history of CC transactions */
CREATE TABLE credit_card_staged_data AS

/* Use of window function to calculate rolling average of days past due
   with 12 month window. For future installments, only care about number 
   remaining as of most current month - will be filtered in query below.
   Also looking at rolling average of monthly delta in cc balance */
WITH cc_stage_2 AS (
SELECT
	sk_id_curr,
	months_balance,
	amt_balance,
	amt_credit_limit_actual,
	sk_dpd,
	monthly_delta_amt_balance,

	AVG(monthly_delta_amt_balance) OVER(
		PARTITION BY sk_id_curr
		ORDER BY months_balance
		ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
	) AS avg_monthly_change_cc_balance,
	
	AVG(sk_dpd) OVER(
		PARTITION BY sk_id_curr
		ORDER BY months_balance
		ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
	) AS avg_ytd_cc_dpd

/* From aggregation that looks at the difference between cc balance
   amount of current row vs the previous row, to determine the monthly
   change in cc balance. */
FROM (
	SELECT 
		sk_id_curr,
		months_balance,
		amt_balance,
		amt_credit_limit_actual,
		sk_dpd,
		
		amt_balance - LAG(amt_balance) OVER(
			PARTITION BY sk_id_curr
			ORDER BY months_balance
		) AS monthly_delta_amt_balance
	
	FROM 
		credit_card_balance	
	) AS cc_stage_1

)
/* Final query to create table based on statements above. Want a table that
   contains the average monthly change in cc balance (past 12 months) and the 
   average "days past due" (past 12 months) as of the most recent month of 
   data, where months_balance = -1. */
SELECT
	sk_id_curr,
	amt_balance as recent_cc_balance,
	amt_credit_limit_actual as current_cc_limit,
	ROUND(avg_monthly_change_cc_balance::numeric, 0) AS avg_monthly_change_cc_balance,
	ROUND(avg_ytd_cc_dpd::numeric, 0) AS avg_ytd_cc_dpd
FROM
	cc_stage_2 
WHERE
	months_balance = -1
ORDER BY
	sk_id_curr
;