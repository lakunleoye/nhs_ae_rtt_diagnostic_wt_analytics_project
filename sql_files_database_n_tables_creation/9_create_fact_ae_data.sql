-- Create fact_ae_data

CREATE TABLE fact_ae_data (
    fact_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    organisation_code VARCHAR(50) NOT NULL,
    
    ae_attendances_type_1 INT,
    ae_attendances_type_2 INT,
    ae_attendances_other_ae_department INT,
    ae_attendances_booked_appointments_type_1 INT,
    ae_attendances_booked_appointments_type_2 INT,
    ae_attendances_booked_appointments_other_department INT,
    
    attendances_over_4hrs_type_1 INT,
    attendances_over_4hrs_type_2 INT,
    attendances_over_4hrs_other_department INT,
    attendances_over_4hrs_booked_appointments_type_1 INT,
    attendances_over_4hrs_booked_appointments_type_2 INT,
    attendances_over_4hrs_booked_appointments_other_department INT,
    
    patients_waited_4_to_12hrs_from_dta INT,
    patients_waited_12_plus_hrs_from_dta INT,
    
    emergency_admissions_via_ae_type_1 INT,
    emergency_admissions_via_ae_type_2 INT,
    emergency_admissions_via_ae_other_ae_department INT,
    other_emergency_admissions INT,

-- Foreign key to access dimension table
    FOREIGN KEY (organisation_code) REFERENCES dim_organi sation(organisation_code)
);

-- Rename multiple columns with inconsistent name
ALTER TABLE fact_ae_data
RENAME COLUMN patients_waited_4_to_12hrs_from_dta to patients_who_have_waited_4_to_12hrs_from_dta_to_admission;

ALTER TABLE fact_ae_data
RENAME COLUMN patients_waited_12_plus_hrs_from_dta to patients_who_have_waited_12_plus_hours_from_dta_to_admission;



-- Populate fact_ae_data from ae_data
INSERT INTO fact_ae_data (
    date,
    organisation_code,
    ae_attendances_type_1,
    ae_attendances_type_2,
    ae_attendances_other_ae_department,
    ae_attendances_booked_appointments_type_1,
    ae_attendances_booked_appointments_type_2,
    ae_attendances_booked_appointments_other_department,
    attendances_over_4hrs_type_1,
    attendances_over_4hrs_type_2,
    attendances_over_4hrs_other_department,
    attendances_over_4hrs_booked_appointments_type_1,
    attendances_over_4hrs_booked_appointments_type_2,
    attendances_over_4hrs_booked_appointments_other_department,
    patients_who_have_waited_4_to_12hrs_from_dta_to_admission,
    patients_who_have_waited_12_plus_hours_from_dta_to_admission,
    emergency_admissions_via_ae_type_1,
    emergency_admissions_via_ae_type_2,
    emergency_admissions_via_ae_other_ae_department,
    other_emergency_admissions
)
SELECT
    date,
    organisation_code,
    ae_attendances_type_1,
    ae_attendances_type_2,
    ae_attendances_other_ae_department,
    ae_attendances_booked_appointments_type_1,
    ae_attendances_booked_appointments_type_2,
    ae_attendances_booked_appointments_other_department,
    attendances_over_4hrs_type_1,
    attendances_over_4hrs_type_2,
    attendances_over_4hrs_other_department,
    attendances_over_4hrs_booked_appointments_type_1,
    attendances_over_4hrs_booked_appointments_type_2,
    attendances_over_4hrs_booked_appointments_other_department,
    patients_who_have_waited_4_to_12hrs_from_dta_to_admission,
    patients_who_have_waited_12_plus_hours_from_dta_to_admission,
    emergency_admissions_via_ae_type_1,
    emergency_admissions_via_ae_type_2,
    emergency_admissions_via_ae_other_ae_department,
    other_emergency_admissions
FROM ae_data
WHERE organisation_code IN (SELECT organisation_code FROM dim_organisation);


-- Add a foreign key to link to dim_date
ALTER TABLE fact_ae_data
ADD CONSTRAINT fk_fact_ae_date
FOREIGN KEY (date) REFERENCES dim_date(date_key);