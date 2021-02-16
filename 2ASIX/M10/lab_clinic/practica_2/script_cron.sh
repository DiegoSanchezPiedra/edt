psql -d lab_clinic -f /var/tmp/M10/script_sql.sql
cp /var/tmp/M10/nous_pacients.csv /var/tmp/M10/hist_pacients/newpacients_$(date +%d-%m-%y_%H:%M).csv
rm /var/tmp/M10/nous_pacients.csv