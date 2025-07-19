
-- Create dim_diagnostic_test from diag_wt_data

CREATE TABLE dim_diagnostic_test (
    diagnostic_id VARCHAR(50) PRIMARY KEY,
    diagnostic_test_name VARCHAR(255)
);

INSERT INTO dim_diagnostic_test (
    diagnostic_id, 
    diagnostic_test_name
    )
SELECT DISTINCT 
    diagnostic_id, 
    diagnostic_test_name
FROM 
    diag_wt_data
WHERE diagnostic_id IS NOT NULL;




