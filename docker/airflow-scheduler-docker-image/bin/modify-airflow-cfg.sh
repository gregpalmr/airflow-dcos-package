CRIPT: modify-airflow-cfg.sh
#
# DESCRIPTION: Modify the airflow configuration based on environment variables
#

echo
echo "SCRIPT: /usr/local/airflow/bin/modify-airflow-cfg.sh "
echo
echo "        Modifying usr/local/airflow/airflow.cfg file."
echo
# Create a tempory file to change the airflow.cfg settings

TMP_CFG="/tmp/airflow.cfg.tmp"
cp /usr/local/airflow/airflow.cfg $TMP_CFG
cp /usr/local/airflow/airflow.cfg /usr/local/airflow/airflow.cfg.orig

# Process any user supplied settings

#
# Change the postgres db connection string. Looks like this by default:
#    sql_alchemy_conn = postgresql+psycopg2://airflow:changeme@airflow-postgresql-0-server.airflow.mesos/airflow-db

# First, set the framework_name part of the conn string
if [ "$FRAMEWORK_NAME" != "" ]
then
     echo " modify-airflow-cfg.sh: FOUND \$FRAMEWORK_NAME = $FRAMEWORK_NAME - Modifying postresql connection string."
     sed -i "s~FRAMEWORK_NAME~$FRAMEWORK_NAME~g" $TMP_CFG
else
     echo " modify-airflow-cfg.sh: NOT FOUND: \$FRAMEWORK_NAME - Not modifying postgresql connection string."
fi

# Next, set the user and password part of the conn string
if [ "$POSTGRES_USER" != "" ] && [ "$POSTGRES_PASSWORD" != "" ]
then
     echo " modify-airflow-cfg.sh: FOUND \$POSTGRES_USER = $POSTGRES_USER and \$POSTGRES_PASSWORD = $POSTGRES_PASSWORD - modifying postgres user and password in connection string."
     sed -i "s~POSTGRES_USER~$POSTGRES_USER~g" $TMP_CFG
     sed -i "s~POSTGRES_PASSWORD~$POSTGRES_PASSWORD~g" $TMP_CFG
fi
# If just the user id was changed...
if [ "$POSTGRES_USER" != "" ] && [ "$POSTGRES_PASSWORD" = "" ]
then
     echo " modify-airflow-cfg.sh: FOUND \$POSTGRES_USER = $POSTGRES_USER - modifying postgres user in connection string."
     sed -i "s~POSTGRES_USER~$POSTGRES_USER~g" $TMP_CFG
fi
# If just the password was changed...
if [ "$POSTGRES_USER" = "" ] && [ "$POSTGRES_PASSWORD" != "" ]
then
     echo " modify-airflow-cfg.sh: FOUND \$POSTGRES_PASSWORD = $POSTGRES_PASSWORD"
     sed -i "s~POSTGRES_PASSWORD~$POSTGRES_PASSWORD~g" $TMP_CFG
fi

if [ "$DAGS_FOLDER" != "" ]
then
     echo " modify-airflow-cfg.sh: FOUND \$DAGS_FOLDER = $DAGS_FOLDER "
     sed -i "s~dags_folder =\$MESOS_SANDBOX/airflow-dags~dags_folder~dags_folder = $DAGS_FOLDER~" $TMP_CFG
fi

if [ "$BASE_LOG_FOLDER" != "" ]
then
     echo " modify-airflow-cfg.sh: FOUND \$BASE_LOG_FOLDER = $BASE_LOG_FOLDER "
     sed -i "s~base_log_folder = \$MESOS_SANDBOX/airflow-logs~base_log_folder = $BASE_LOG_FOLDER~" $TMP_CFG
fi

if [ "$REMOTE_BASE_LOG_FOLDER" != "" ]
then
     sed -i "s~remote_base_log_folder =~remote_base_log_folder = $REMOTE_BASE_LOG_FOLDER~" $TMP_CFG
fi

if [ "$REMOTE_LOG_CONN_ID" != "" ]
then
     sed -i "s~remote_log_conn_id =~remote_log_conn_id = $REMOTE_LOG_CONN_ID~" $TMP_CFG
fi

if [ "$ENCRYPT_S3_LOGS" != "" ]
then
     sed -i "s~encrypt_s3_logs = False~encrypt_s3_logs = $ENCRYPT_S3_LOGS~" $TMP_CFG
fi

if [ "$SQL_ALCHEMY_POOL_SIZE" != "" ]
then
     sed -i "s~sql_alchemy_pool_size = 5~sql_alchemy_pool_size = $SQL_ALCHEMY_POOL_SIZE~" $TMP_CFG
fi

if [ "$PARALLELISM" != "" ]
then
     sed -i "s~parallelism = 32~parallelism = $PARALLELISM~" $TMP_CFG
fi

if [ "$DAG_CONCURRENCY" != "" ]
then
     sed -i "s~dag_concurrency = 16~dag_concurrency = $DAG_CONCURRENCY~" $TMP_CFG
fi

if [ "$DAGS_ARE_PAUSED_AT_CREATION" != "" ]
then
     sed -i "s~dags_are_paused_at_creation = True~dags_are_paused_at_creation = $DAGS_ARE_PAUSED_AT_CREATION~" $TMP_CFG
fi

if [ "$MAX_ACTIVE_RUNS_PER_DAG" != "" ]
then
     sed -i "s~max_active_runs_per_dag = 16~max_active_runs_per_dag = $MAX_ACTIVE_RUNS_PER_DAG~" $TMP_CFG
fi

if [ "$LOAD_EXAMPLES" != "" ]
then
     sed -i "s~load_examples = True~load_examples = $LOAD_EXAMPLES~" $TMP_CFG
fi

if [ "$SECURITY" != "" ]
then
     sed -i "s~security =~security = $SECURITY~" $TMP_CFG
fi

if [ "$WEB_SERVER_SSL_CERT" != "" ]
then
     sed -i "s~web_server_ssl_cert =~web_server_ssl_cert = $WEB_SERVER_SSL_CERT~" $TMP_CFG
fi

if [ "$WEB_SERVER_SSL_KEY" != "" ]
then
     sed -i "s~web_server_ssl_key =~web_server_ssl_key = $WEB_SERVER_SSL_KEY~" $TMP_CFG
fi

if [ "$WEBSERVER_AUTHENTICATE" != "" ]
then
     sed -i "s~webserver_authenticate =~authenticate = $WEBSERVER_AUTHENTICATE~" $TMP_CFG
else
     sed -i "s~webserver_authenticate =~authenticate =~" $TMP_CFG
fi

if [ "$SMTP_HOST" != "" ]
then
     sed -i "s~smtp_host = localhost~smtp_host = $SMTP_HOST~" $TMP_CFG
fi

if [ "$SMTP_STARTTLS" != "" ]
then
     sed -i "s~smtp_starttls = True~smtp_starttls = $SMTP_STARTTLS~" $TMP_CFG
fi

if [ "$SMTP_SSL" != "" ]
then
     sed -i "s~smtp_ssl = False~smtp_ssl = $SMTP_SSL~" $TMP_CFG
fi

if [ "$SMTP_USER" != "" ]
then
     sed -i "s~# smtp_user = airflow~smtp_user = $SMTP_USER~" $TMP_CFG
fi

if [ "$SMTP_PASSWORD" != "" ]
then
     sed -i "s~# smtp_password = airflow~smtp_password = $SMTP_PASSWORD~" $TMP_CFG
fi

if [ "$SMTP_PORT" != "" ]
then
     sed -i "s~smtp_port = 25~smtp_port = $SMTP_PORT~" $TMP_CFG
fi

if [ "$SMTP_MAIL_FROM" != "" ]
then
     sed -i "s~smtp_mail_from = airflow@airflow.com~smtp_mail_from = $smtp_mail_from~" $TMP_CFG
fi

if [ "$JOB_HEARTBEAT_SEC" != "" ]
then
     sed -i "s~job_heartbeat_sec = 5~job_heartbeat_sec = $JOB_HEARTBEAT_SEC~" $TMP_CFG
fi

if [ "$SCHEDULER_HEARTBEAT_SEC" != "" ]
then
     sed -i "s~scheduler_heartbeat_sec = 5~scheduler_heartbeat_sec = $SCHEDULER_HEARTBEAT_SEC~" $TMP_CFG
fi

if [ "$RUN_DURATION" != "" ]
then
     sed -i "s~run_duration = -1~run_duration = $RUN_DURATION~" $TMP_CFG
fi

if [ "$MIN_FILE_PROCESS_INTERVAL" != "" ]
then
     sed -i "s~min_file_process_interval = 0~min_file_process_interval = $MIN_FILE_PROCESS_INTERVAL~" $TMP_CFG
fi

if [ "$DAG_DIR_LIST_INTERVAL" != "" ]
then
     sed -i "s~dag_dir_list_interval = 300~dag_dir_list_interval = $DAG_DIR_LIST_INTERVAL~" $TMP_CFG
fi

if [ "$PRINT_STATS_INTERVAL" != "" ]
then
     sed -i "s~print_stats_interval = 30~print_stats_interval = $PRINT_STATS_INTERVAL~" $TMP_CFG
fi

if [ "$CHILD_PROCESS_LOG_DIRECTORY" != "" ]
then
     sed -i "s~child_process_log_directory = \$MESOS_SANDBOX/airflow-child-logs~child_process_log_directory = $CHILD_PROCESS_LOG_DIRECTORY~" $TMP_CFG
fi

if [ "$SCHEDULER_ZOMBIE_TASK_THRESHOLD" != "" ]
then
     sed -i "s~scheduler_zombie_task_threshold = 30~scheduler_zombie_task_threshold = $SCHEDULER_ZOMBIE_TASK_THRESHOLD~" $TMP_CFG
fi

if [ "$CATCHUP_BY_DEFAULT" != "" ]
then
     sed -i "s~catchup_by_default = True~catchup_by_default = $CATCHUP_BY_DEFAULT~" $TMP_CFG
fi

if [ "$MAX_THREADS" != "" ]
then
     sed -i "s~max_threads = 2~max_threads = $MAX_THREADS~" $TMP_CFG
fi

if [ "$SCHEDULER_AUTHENTICATE" != "" ]
then
     sed -i "s~scheduler_authenticate~authenticate = $SCHEDULER_AUTHENTICATE~" $TMP_CFG
else
     sed -i "s~scheduler_authenticate =~authenticate =~" $TMP_CFG
fi

if [ "$FRAMEWORK_NAME" != "" ]
then
     sed -i "s~framework_name = Airflow~framework_name = $FRAMEWORK_NAME~" $TMP_CFG
fi

if [ "$TASK_CPU" != "" ]
then
     sed -i "s~task_cpu = 1~task_cpu = $TASK_CPU~" $TMP_CFG
fi

if [ "$TASK_MEMORY" != "" ]
then
     sed -i "s~task_memory = 1024~task_memory = $TASK_MEMORY~" $TMP_CFG
fi

if [ "$CHECKPOINT" != "" ]
then
     sed -i "s~checkpoint = False~checkpoint = $CHECKPOINT~" $TMP_CFG
fi

if [ "$MESOS_AUTHENTICATE" != "" ]
then
     sed -i "s~mesos_authenticate~authenticate = $MESOS_AUTHENTICATE~" $TMP_CFG
else
     sed -i "s~mesos_authenticate =~authenticate = ~" $TMP_CFG
fi

if [ "$USE_DOCKER_CONTAINER" != "" ]
then
     sed -i "s~use_docker_container = True~use_docker_container = $USE_DOCKER_CONTAINER~" $TMP_CFG
fi

if [ "$DEFAULT_DOCKER_CONTAINER_IMAGE" != "" ]
then
     sed -i "s~default_docker_container_image = gregpalmermesosphere/airflow-dcos-dcos:latest~default_docker_container_image = $DEFAULT_DOCKER_CONTAINER_IMAGE~" $TMP_CFG
fi

if [ "$xxx" != "" ]
then
     sed -i "s~xxx~xxx~" $TMP_CFG
fi

if [ "$ENABLE_DEBUG_LOG" == "True" ] || [ "$ENABLE_DEBUG_LOG" == "TRUE" ] || [ "$ENABLE_DEBUG_LOG" == "true" ]
then
     sed -i "s~logging.INFO~logging.DEBUG~" /usr/lib/python2.7/site-packages/airflow/settings.py
fi

# move modified copy of airflow.cfg to the /usr/local/airflow dir
mv $TMP_CFG /usr/local/airflow/airflow.cfg

echo
echo
echo " ########### Contents of /usr/local/airflow/airflow.cfg #############"
echo
cat /usr/local/airflow/airflow.cfg
echo
echo

# End of script

