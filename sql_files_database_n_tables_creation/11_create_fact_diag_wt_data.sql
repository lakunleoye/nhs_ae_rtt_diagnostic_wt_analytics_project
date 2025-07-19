-- Create fact_diag_wt_data

CREATE TABLE fact_diag_wt_data (
    fact_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    
    organisation_code VARCHAR(50) NOT NULL,
    diagnostic_id VARCHAR(20) NOT NULL,

    total_waiting_list INT,
    number_waiting_6_plus_weeks INT,
    number_waiting_13_plus_weeks INT,
    percentage_waiting_6_plus_weeks NUMERIC(5, 2),
    
    planned_tests_or_procedures INT,
    unscheduled_tests_or_procedures INT,
    waiting_list_tests_or_procedures_excluding_planned INT,

    -- Foreign keys to access dimension tables
    FOREIGN KEY (organisation_code) REFERENCES dim_organisation(organisation_code),
    FOREIGN KEY (diagnostic_id) REFERENCES dim_diagnostic_test(diagnostic_id)
);
    

-- Populate fact_diag_wt_data from diag_wt_data

INSERT INTO fact_diag_wt_data (
    date,
    organisation_code,
    diagnostic_id,
    total_waiting_list,
    number_waiting_6_plus_weeks,
    number_waiting_13_plus_weeks,
    percentage_waiting_6_plus_weeks,
    planned_tests_or_procedures,
    unscheduled_tests_or_procedures,
    waiting_list_tests_or_procedures_excluding_planned
)
SELECT
    d.date,
    d.organisation_code,
    d.diagnostic_id::VARCHAR,  -- cast to match VARCHAR type
    NULLIF(d.total_waiting_list::TEXT, '')::INT,
    NULLIF(d.number_waiting_6_plus_weeks::TEXT, '')::INT,
    NULLIF(d.number_waiting_13_plus_weeks::TEXT, '')::INT,
    NULLIF(d.percentage_waiting_6_plus_weeks::TEXT, '')::NUMERIC,
    NULLIF(d.planned_tests_or_procedures::TEXT, '')::INT,
    NULLIF(d.unscheduled_tests_or_procedures::TEXT, '')::INT,
    NULLIF(d.waiting_list_tests_or_procedures_excluding_planned::TEXT, '')::INT
FROM diag_wt_data d
INNER JOIN dim_organisation o ON d.organisation_code = o.organisation_code
INNER JOIN dim_diagnostic_test dt ON d.diagnostic_id::VARCHAR = dt.diagnostic_id
WHERE d.diagnostic_id IS NOT NULL AND d.diagnostic_id::TEXT <> '';


-- Add a foreign key to link to dim_date
ALTER TABLE fact_diag_wt_data
ADD CONSTRAINT fk_fact_diag_wt_date
FOREIGN KEY (date) REFERENCES dim_date(date_key);

