

-- Modification for direct loading in posgres terminal

\copy ae_data FROM 'C:\Users\User\Documents\Data Science\NHS_new_project\NHS_ae_rtt_diag_project\Cleaned_data\csv_files\ae_data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy diag_wt_data FROM 'C:\Users\User\Documents\Data Science\NHS_new_project\NHS_ae_rtt_diag_project\Cleaned_data\csv_files\diag_wt_data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
\copy rtt_data FROM 'C:\Users\User\Documents\Data Science\NHS_new_project\NHS_ae_rtt_diag_project\Cleaned_data\csv_files\rtt_data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
