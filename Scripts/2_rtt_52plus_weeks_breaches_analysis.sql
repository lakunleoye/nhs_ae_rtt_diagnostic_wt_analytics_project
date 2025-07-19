
--Query to build a filtered, enriched dataset of RTT 52+ week breaches over the last 6 months
WITH recent_date AS(
SELECT 
	MAX(date) max_date
FROM
	fact_rtt_data f 
), 
rtt_52plus_weeks_trend AS(
SELECT
	f.date,
	r.regional_name, 
	f.organisation_code,
	o.organisation_name,
	t.treatment_function,
	f.total_52_plus_weeks
FROM
	fact_rtt_data f 
	JOIN dim_date d ON f."date"  = d.date_key
	JOIN dim_organisation o ON f.organisation_code = o.organisation_code
	JOIN dim_region r ON o.regional_code = r.regional_code
	JOIN dim_treatment_function t ON f.treatment_function_code = t.treatment_function_code
	JOIN recent_date rd ON f.date >= (rd.max_date - INTERVAL '6 Months') -- Ensures the query always analyzes the latest 6 months dynamically
WHERE f.total_52_plus_weeks IS NOT NULL  
AND t.treatment_function <> 'Total'										 -- Filters out aggregate rows to focus on specific specialties
)
-- Query to aggregate breaches by organisation and specialty, and rank top issues
SELECT
	regional_name,
	organisation_name,
	treatment_function,
	SUM(total_52_plus_weeks) total_breaches_52_plus, 	   --identifies areas of greatest backlog
	ROUND(AVG(total_52_plus_weeks)) avg_monthly_breaches,  --distinguishes ongoing issues from one-time spikes
	MAX(date) AS last_reported_month
FROM 
	rtt_52plus_weeks_trend
GROUP BY
	regional_name,
	organisation_name,
	treatment_function
ORDER BY
	total_breaches_52_plus DESC								--Prioritizes most critical backlogs for action
LIMIT 
	10;														--Limits to top 10 to support focused intervention