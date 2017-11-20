#!/bin/bash
#
# SCRIPT: start-scheduler.sh
#
# DESCRIPTION: Setup the airflow configuration and start the airflow scheduler
#

# Change the /usr/local/airflow.cfg settings based on environment variables passed in
/usr/local/airflow/bin/modify-airflow-cfg.sh

/usr/bin/airflow scheduler -p

# End of script
