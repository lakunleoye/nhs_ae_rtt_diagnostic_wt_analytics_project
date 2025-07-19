-- Create dim_diagnostic_test from rtt_data

CREATE TABLE dim_treatment_function (
    treatment_function_code VARCHAR(50) PRIMARY KEY,
    treatment_function VARCHAR(255)
);

INSERT INTO dim_treatment_function (
    treatment_function_code, 
    treatment_function
    )
SELECT DISTINCT 
    treatment_function_code, 
    treatment_function
FROM 
    rtt_data
WHERE treatment_function_code IS NOT NULL;