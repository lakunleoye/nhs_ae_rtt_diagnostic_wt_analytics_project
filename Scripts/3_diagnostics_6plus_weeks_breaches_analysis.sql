--Find the most recent test date to focus on the latest available data
WITH recent_test_date AS(
SELECT 
	MAX(date) AS max_test_date
FROM
	fact_diag_wt_data 
),

--Aggregate number of patients waiting 6+ weeks by month, region, organisation, and test
-- for the last 3 months (based on the most recent test date)
monthly_breaches_last_3months AS (
SELECT 
	TO_CHAR(f.date, 'YYYY-MM')AS test_month,		-- Group by year and month for trend analysis
	r.regional_name,
	o.organisation_name,
	d.diagnostic_test_name,
	SUM(f.number_waiting_6_plus_weeks)AS breaches_6plus_weeks		-- Total breaches this month
FROM 
	fact_diag_wt_data f
	JOIN dim_diagnostic_test d ON f.diagnostic_id = d.diagnostic_id
	JOIN dim_organisation o ON f.organisation_code = o.organisation_code
	JOIN recent_test_date rt ON f."date" >=(rt.max_test_date - INTERVAL '2 months')	-- Last 3 months data
	JOIN dim_region r ON o.regional_code = r.regional_code
	JOIN dim_date dd ON f."date" = dd.date_key
GROUP BY
	test_month,
	r.regional_name,
	o.organisation_name,
	d.diagnostic_test_name
),

--Rank months descending and get previous month’s breach count to compare trends month-over-month
monthly_rank AS(
SELECT
	ROW_NUMBER() OVER(PARTITION BY organisation_name, diagnostic_test_name ORDER BY test_month DESC) AS month_rank,
	*,
	LAG(breaches_6plus_weeks )OVER(PARTITION BY organisation_name, diagnostic_test_name ORDER BY test_month DESC)AS previous_month_6plus_weeks_breaches
FROM
	monthly_breaches_last_3months
), 

--Calculate change and percentage change in breaches from previous month
growth_trend AS(
SELECT
	*,
	(breaches_6plus_weeks - previous_month_6plus_weeks_breaches) AS monthly_change,-- Absolute increase/decrease
	ROUND(100*(breaches_6plus_weeks - previous_month_6plus_weeks_breaches)/
	NULLIF(previous_month_6plus_weeks_breaches, 0),
	2) 
	AS percent_monthly_change  -- Percent change month-over-month
FROM
	monthly_rank
)

-- Show top 25 cases with biggest percentage increases in breaches to highlight areas needing attention
SELECT
	*
FROM
	growth_trend
WHERE
	percent_monthly_change
	IS NOT NULL				-- Exclude first month with no prior comparison
ORDER BY 
	percent_monthly_change DESC
LIMIT 20;


	
	