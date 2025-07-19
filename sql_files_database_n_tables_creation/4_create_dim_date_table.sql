CREATE TABLE dim_date (
    date_key           DATE PRIMARY KEY,      -- Always 1st of month
    fiscal_year        INT,
    fiscal_quarter     INT,
    calendar_year      INT,
    calendar_month     INT,
    month_name         TEXT,
    fiscal_month       INT                    -- 1 = April, 12 = March
);

-- Adjust the date range to fiscal year (202404 to 202503)
INSERT INTO dim_date (
    date_key, 
    fiscal_year, 
    fiscal_quarter, 
    calendar_year, 
    calendar_month, 
    month_name, 
    fiscal_month
    )
SELECT
    month_start::date AS date_key,
    CASE 
        WHEN EXTRACT(MONTH FROM month_start) >= 4 THEN EXTRACT(YEAR FROM month_start)::INT + 1
        ELSE EXTRACT(YEAR FROM month_start)::INT
    END AS fiscal_year,
    CASE 
        WHEN EXTRACT(MONTH FROM month_start) IN (4,5,6) THEN 1
        WHEN EXTRACT(MONTH FROM month_start) IN (7,8,9) THEN 2
        WHEN EXTRACT(MONTH FROM month_start) IN (10,11,12) THEN 3
        ELSE 4
    END AS fiscal_quarter,
    EXTRACT(YEAR FROM month_start)::INT AS calendar_year,
    EXTRACT(MONTH FROM month_start)::INT AS calendar_month,
    TO_CHAR(month_start, 'Month') AS month_name,
    CASE 
        WHEN EXTRACT(MONTH FROM month_start) >= 4 THEN EXTRACT(MONTH FROM month_start) - 3
        ELSE EXTRACT(MONTH FROM month_start) + 9
    END AS fiscal_month
FROM
    generate_series('2024-04-01'::date, '2025-03-01'::date, interval '1 month') AS month_start;

