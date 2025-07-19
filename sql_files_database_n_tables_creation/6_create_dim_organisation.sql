
-- Create dim_organisation table from diag_wt_data

CREATE TABLE dim_organisation (
    organisation_code VARCHAR(50) PRIMARY KEY,
    organisation_name VARCHAR(255),
    regional_code VARCHAR(100),
    FOREIGN KEY (regional_code) REFERENCES dim_region(regional_code)
);

/* CLEAN UP organisation_code
check for duplicates in diag_wt_data
SELECT 
    organisation_code, 
    COUNT(*)
FROM 
    diag_wt_data
GROUP BY 
    organisation_code
HAVING COUNT(*) > 1;

-- Check if organisation_code has multiple names or regions
SELECT 
    organisation_code, 
    COUNT(DISTINCT organisation_name), 
    COUNT(DISTINCT regional_code)
FROM 
    diag_wt_data
GROUP BY 
    organisation_code
HAVING COUNT(*) > 1;

-- Investigate the Duplicates
SELECT *
FROM diag_wt_data
WHERE organisation_code IN ('NT448', 'NT449', 'NT450', 'NV6', 'RAX', 'RRE', 'RW1', 'RWD')
ORDER BY organisation_code;


Key issue: Same organisation_code appears with two different organisation_names, both in the same regional_code
Due to: (1) Name change over time (rebranding, merger, etc.). (2)Inconsistent naming in source system (e.g., legacy entries).
Solution:
Create and use a manual mapping table to cleanly resolve the organisation_name inconsistencies when populating dim_organisation.
*/

-- Create the Mapping Table
CREATE TABLE organisation_name_mapping (
    organisation_code VARCHAR(50) PRIMARY KEY,
    preferred_name VARCHAR(255)
);

-- Insert the correct, standardized names for only those organisation_codes that are problematic
INSERT INTO organisation_name_mapping (organisation_code, preferred_name) VALUES
('RW1', 'Hampshire and Isle of Wight Healthcare NHS Foundation Trust'),
('NT448', 'Huddersfield Private Hospital'),
('NT449', 'Lancaster Private Hospital'),
('NT450', 'Lincoln Private Hospital'),
('NV6', 'PDS Medical Ltd'),
('RAX', 'Kingston and Richmond NHS Foundation Trust'),
('RRE', 'Midlands Partnership University NHS Foundation Trust'),
('RWD', 'United Lincolnshire Teaching Hospitals NHS Trust');


-- Insert into dim_organisation Using the Mapping

WITH resolved_orgs AS (
    SELECT 
        d.organisation_code,
        COALESCE(MAX(m.preferred_name), MAX(d.organisation_name)) AS organisation_name,
        MAX(d.regional_code) AS regional_code
    FROM diag_wt_data d
    LEFT JOIN organisation_name_mapping m
      ON d.organisation_code = m.organisation_code
    WHERE d.regional_code IN (SELECT regional_code FROM dim_region)
    GROUP BY d.organisation_code
)
INSERT INTO dim_organisation (
    organisation_code,
    organisation_name,
    regional_code
)
SELECT *
FROM resolved_orgs
ON CONFLICT (organisation_code) DO NOTHING;


