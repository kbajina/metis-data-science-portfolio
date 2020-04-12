/* Staged data from pos_cash_balance - history of past cash loans */
CREATE TABLE pos_cash_staged_data AS

/* Use of window function to calculate rolling average of days past due
   with 12 month window. For future installments, only care about number
   remaining as of most current month - will be filtered in query below */
WITH pos_cash_stage_2 AS (
SELECT
	sk_id_curr,
	months_balance,
	cash_loan_max_future_installments,
	cash_loan_max_dpd,
	AVG(cash_loan_max_dpd) OVER(
		PARTITION BY sk_id_curr
		ORDER BY months_balance
		ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
	) AS ytd_cash_loan_dpd

/* From aggregation that looks at max # of future loan installments and max
   days past due, for each specific month. This is done to account for multiple
   cash loans that may be open - only care about the most significant loan as of
   that specific month */
FROM (
	SELECT
		sk_id_curr,
		months_balance,
	 	name_contract_status,
		MAX(cnt_instalment_future) AS cash_loan_max_future_installments,
		MAX(sk_dpd) AS cash_loan_max_dpd
	FROM
		pos_cash_balance
	GROUP BY
		sk_id_curr,
		months_balance,
		name_contract_status
	) AS pos_cash_stage_1

WHERE
	(months_balance > -13)
)
/* Final query to create table based on statements above. Want a table that
   contains the # of "future installments" and ytd average "days past due"
   as of the most recent month of data, where months_balance = -1. */
SELECT
	sk_id_curr,
	cash_loan_max_future_installments,
	ROUND(ytd_cash_loan_dpd::numeric, 1) AS ytd_cash_loan_dpd
FROM
	pos_cash_stage_2
WHERE
	months_balance = -1
ORDER BY
	sk_id_curr
;
