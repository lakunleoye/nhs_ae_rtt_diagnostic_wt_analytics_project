
-- Create ae_data table

CREATE TABLE public.ae_data
(
    index INT,
    date DATE,
    organisation_code VARCHAR,
    regional_name TEXT,
    organisation_name TEXT,
    ae_attendances_type_1 INT,
    ae_attendances_type_2 INT,
    ae_attendances_other_ae_department INT,
    ae_attendances_booked_appointments_type_1 INT,
    ae_attendances_booked_appointments_type_2 INT,
    ae_attendances_booked_appointments_other_department INT,
    attendances_over_4hrs_type_1 INT,
    attendances_over_4hrs_type_2 INT,
    attendances_over_4hrs_type_other_department INT,
    attendances_over_4hrs_booked_appointment_type_1 INT,
    attendances_over_4hrs_booked_appointment_type_2 INT,
    attendances_over_4hrs_booked_appointment_other_department INT,
    patients_who_have_waited_4_to_12hrs_from_data_to_admission INT,
    patients_who_have_waited_12_plus_hours_from_dta_to_admission INT,
    emergency_admissions_via_ae_type_1 INT,
    emergency_admissions_via_ae_type_2 INT,
    emergency_admissions_via_ae_other_ae_department INT,
    other_emergency_admissions INT
);

-- Create rtt_data table

CREATE TABLE public.rtt_data
(
    index INT,
    date DATE,
    regional_code VARCHAR,
    organisation_code VARCHAR,
    organisation_name TEXT,
    treatment_function_code VARCHAR,
    treatment_function VARCHAR,
    total_number_of_incomplete_pathways INT,
    total_within_18_weeks INT,
    percentage_within_18_weeks NUMERIC,
    average_median_waiting_time_in_weeks NUMERIC,
    the_92nd_percentile_waiting_time_in_weeks NUMERIC,
    total_52_plus_weeks INT,
    total_78_plus_weeks INT,
    total_65_plus_weeks INT
);


-- Create diag_wt_data table

CREATE TABLE public.diag_wt_data
(
    index INT,
    date DATE,
    regional_code VARCHAR,
    regional_name TEXT,
    organisation_code VARCHAR,
    organisation_name TEXT,
    diagnostic_id INT,
    diagnostic_test_name VARCHAR,
    total_waiting_list INT,
    number_waiting_6_plus_weeks INT,
    number_waiting_13_plus_weeks INT,
    percentage_waiting_6_plus_weeks NUMERIC,
    planned_tests_or_procedures INT,
    unscheduled_tests_or_procedures INT,
    waiting_list_tests_or_procedures_excluding_planned INT
);


-- Set ownership of the table to the postgres user
ALTER TABLE public.ae_data OWNER to postgres;
ALTER TABLE public.rtt_data OWNER to postgres;
ALTER TABLE public.diag_wt_data OWNER to postgres;

-- Rename multiple columns with inconsistent name
ALTER TABLE ae_data
RENAME COLUMN attendances_over_4hrs_booked_appointment_type_1 to attendances_over_4hrs_booked_appointments_type_1;

ALTER TABLE ae_data
RENAME COLUMN attendances_over_4hrs_booked_appointment_type_2 to attendances_over_4hrs_booked_appointments_type_2;

ALTER TABLE ae_data
RENAME COLUMN attendances_over_4hrs_booked_appointment_other_department to aattendances_over_4hrs_booked_appointments_other_department;

ALTER TABLE ae_data
RENAME COLUMN attendances_over_4hrs_type_other_department to attendances_over_4hrs_other_department;

ALTER TABLE ae_data
RENAME COLUMN patients_who_have_waited_4_to_12hrs_from_data_to_admission to patients_who_have_waited_4_to_12hrs_from_dta_to_admission;

ALTER TABLE ae_data
RENAME COLUMN aattendances_over_4hrs_booked_appointments_other_department to attendances_over_4hrs_booked_appointments_other_department;