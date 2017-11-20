#!/bin/bash
#
# SCRIPT: start-webserver.sh
#
# DESCRIPTION: Setup the airflow configuration and start the airflow webserver
#

# Change the webserver port from port 8080 to the port assigned by Mesos ($PORT0)
if [ "$PORT0" != "" ]
then
     echo " start-webserver.sh: FOUND \$PORT0 = $PORT0 - Modifying Airflow Webserver HTTP Port in airflow.cfg."
     cp /usr/local/airflow/airflow.cfg /usr/local/airflow/airflow.cfg.orig0
     sed -i "s~8080~$PORT0~g" /usr/local/airflow/airflow.cfg
else
     echo " start-webserver.sh: NOT FOUND \$PORT0  - Not Modifying Airflow Webserver HTTP Port in airflow.cfg."
fi

# Change the /usr/local/airflow.cfg settings based on environment variables passed in
/usr/local/airflow/bin/modify-airflow-cfg.sh

/usr/bin/airflow webserver

# End of script
