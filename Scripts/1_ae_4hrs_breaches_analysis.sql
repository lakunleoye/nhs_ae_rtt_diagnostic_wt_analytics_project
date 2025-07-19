
-- Find the most recent date in the data
WITH recent_date AS(
	SELECT 
		MAX(f.date)AS max_date
	FROM
		fact_ae_data f 
),

-- Get breach data for the most recent 3 months
monthly_4hrs_breaches_recent_3months AS(
SELECT
	TO_CHAR(f.date, 'YYYY-MM') AS attendance_month,
	r.regional_name,
	o.organisation_name,
	f.attendances_over_4hrs_type_1,
	f.attendances_over_4hrs_type_2,
	f.attendances_over_4hrs_other_department,
	(f.attendances_over_4hrs_type_1 + f.attendances_over_4hrs_type_2 + f.attendances_over_4hrs_other_department) AS total_4hrs_breaches
FROM 
	fact_ae_data f
	JOIN dim_organisation o ON f.organisation_code = o.organisation_code
	JOIN dim_region r ON o.regional_code = r.regional_code
	JOIN dim_date d ON f."date" = d.date_key
	JOIN recent_date rd ON f.date >= (max_date - INTERVAL '2 Months')
),

-- Rank months and get previous month's breach count
monthly_ranks_4hrs_breaches AS(
SELECT
	ROW_NUMBER() OVER(PARTITION BY organisation_name ORDER BY attendance_month  DESC) AS month_rank,
	*,
	LAG(total_4hrs_breaches )OVER(PARTITION BY organisation_name ORDER BY attendance_month DESC) AS previous_month_4hrs_breaches
FROM
	monthly_4hrs_breaches_recent_3months
),

-- Calculate monthly change and percent change
attendance_trend AS(
SELECT
	*,
	(total_4hrs_breaches - previous_month_4hrs_breaches) AS monthly_change,
	ROUND(100*(total_4hrs_breaches - previous_month_4hrs_breaches)/
	NULLIF(previous_month_4hrs_breaches, 0),2) AS percent_monthly_change
FROM
	monthly_ranks_4hrs_breaches
)

-- Final output — top 20 entries with lowest monthly change
SELECT
	month_rank,
	attendance_month,
	regional_name,
	organisation_name,
	total_4hrs_breaches,
	previous_month_4hrs_breaches,
	monthly_change,
	percent_monthly_change 
FROM
	attendance_trend
ORDER BY
	monthly_change,
	percent_monthly_change
LIMIT 20;