package com.mesosphere.sdk.airflow.scheduler;


import org.junit.Test;

import com.mesosphere.sdk.testing.ServiceTestRunner;

public class ServiceTest {

    @Test
    public void testSpec() throws Exception {
        new ServiceTestRunner()

                .setPodEnv("service", "AIRFLOW_VERSION", "1.8.0")
                .setPodEnv("service", "PORT_API", "8080")
                .setPodEnv("service", "FRAMEWORK_NAME", "airflow")
                .setPodEnv("service", "SERVICE_USER", "airflow")

                .setPodEnv("postgresql", "DB_CPUS", "1.0")
                .setPodEnv("postgresql", "DB_MEM", "1024")
                .setPodEnv("postgresql", "DB_DISK_TYPE", "ROOT")
                .setPodEnv("postgresql", "DB_DISK_SIZE", "51200")
                .setPodEnv("postgresql", "POSTGRES_DOCKER_IMAGE", "postgres:9.6")
                .setPodEnv("postgresql", "DB_USER", "airflow-admin")
                .setPodEnv("postgresql", "DB_USER_PASSWORD", "changeme")
                
                .setPodEnv("dag-scheduler", "SCHEDULER_CPUS", "1.0")
                .setPodEnv("dag-scheduler","SCHEDULER_MEM", "1024")
                .setPodEnv("dag-scheduler","SCHEDULER_DISK_TYPE", "ROOT")
                .setPodEnv("dag-scheduler","SCHEDULER_DISK_SIZE", "20480")
                .setPodEnv("dag-scheduler","AIRFLOW_SCHEDULER_DOCKER_IMAGE", "gregpalmermesosphere/airflow-dcos-package:1.8.0-1.0.1")
                .setPodEnv("dag-scheduler","PARALLELISM", "32")
                .setPodEnv("dag-scheduler","DAG_CONCURRENCY", "16")
                .setPodEnv("dag-scheduler","MAX_ACTIVE_RUNS_PER_DAG", "16")
                .setPodEnv("dag-scheduler","USE_DOCKER_CONTAINER", "True")
                .setPodEnv("dag-scheduler","DEFAULT_DOCKER_CONTAINER_IMAGE", "gregpalmermesosphere/airflow-dcos-package:1.8.0-1.0.1")

                .setPodEnv("webserver", "WEBSERVER_CPUS", "1.0")
                .setPodEnv("webserver", "WEBSERVER_MEM", "1024")
                .setPodEnv("webserver", "WEBSERVER_DISK_TYPE", "ROOT")
                .setPodEnv("webserver", "WEBSERVER_DISK_SIZE", "500")

                .run();
    }
}

