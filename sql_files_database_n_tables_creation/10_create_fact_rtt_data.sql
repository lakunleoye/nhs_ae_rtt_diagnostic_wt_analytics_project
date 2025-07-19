-- Create fact_rtt_data

CREATE TABLE fact_rtt_data (
    fact_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    organisation_code VARCHAR(50) NOT NULL,
    treatment_function_code VARCHAR(10),
    
    total_number_of_incomplete_pathways INT,
    total_within_18_weeks INT,
    percentage_within_18_weeks NUMERIC(5, 2),
    average_median_waiting_time_in_weeks NUMERIC(5, 2),
    the_92nd_percentile_waiting_time_in_weeks NUMERIC(5, 2),
    
    total_52_plus_weeks INT,
    total_65_plus_weeks INT,
    total_78_plus_weeks INT,

-- Foreign keys to access dimension tables
    FOREIGN KEY (organisation_code) REFERENCES dim_organisation(organisation_code),
    FOREIGN KEY (treatment_function_code) REFERENCES dim_treatment_function(treatment_function_code)
);

-- Populate fact_rtt_data from rtt_data
INSERT INTO fact_rtt_data (
    date,
    organisation_code,
    treatment_function_code,
    total_number_of_incomplete_pathways,
    total_within_18_weeks,
    percentage_within_18_weeks,
    average_median_waiting_time_in_weeks,
    the_92nd_percentile_waiting_time_in_weeks,
    total_52_plus_weeks,
    total_65_plus_weeks,
    total_78_plus_weeks
)
SELECT
    r.date,
    r.organisation_code,
    r.treatment_function_code,
    r.total_number_of_incomplete_pathways,
    r.total_within_18_weeks,
    r.percentage_within_18_weeks,
    r.average_median_waiting_time_in_weeks,
    r.the_92nd_percentile_waiting_time_in_weeks,
    r.total_52_plus_weeks,
    r.total_65_plus_weeks,
    r.total_78_plus_weeks
FROM rtt_data r
INNER JOIN dim_organisation o ON r.organisation_code = o.organisation_code
INNER JOIN dim_treatment_function tf ON r.treatment_function_code = tf.treatment_function_code;


-- Add a foreign key to link to dim_date
ALTER TABLE fact_rtt_data
ADD CONSTRAINT fk_fact_rtt_date
FOREIGN KEY (date) REFERENCES dim_date(date_key);