#!/bin/bash
#
# SCRIPT: resetdb.sh
#
# DESCRIPTION: Setup the airflow configuration and reset the Postgres database schema
#

# Change the /usr/local/airflow.cfg settings based on environment variables passed in
/usr/local/airflow/bin/modify-airflow-cfg.sh

/usr/bin/airflow resetdb

# End of script
