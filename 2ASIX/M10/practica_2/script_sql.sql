\COPY pacients_tmp FROM 'var/tmp/m10/nous_pacients.csv' DELIMITER ',' CSV;
select update();