-- Create dim_region table

CREATE TABLE dim_region ( 
    regional_code VARCHAR(50) PRIMARY KEY,
    regional_name VARCHAR(255)
);

INSERT INTO dim_region (
    regional_code, 
    regional_name
)
SELECT DISTINCT
    regional_code, 
    regional_name
FROM 
    diag_wt_data

-- Filter out NULL values for PRIMARY KEY constraint not to fail

WHERE 
    regional_code IS NOT NULL

-- Use ON CONFLICT to avoid errors and duplicate inserts

ON CONFLICT (regional_code) DO NOTHING;

