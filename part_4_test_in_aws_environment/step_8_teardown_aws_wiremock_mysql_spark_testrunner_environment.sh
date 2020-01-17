#!/usr/bin/env bash

figlet -w 160 -f standard "Teardown AWS Wiremock MySQL Spark Testrunner Environment"

cd ../src/iac/terraform-wiremock-mysql-spark-testrunner

terraform destroy -auto-approve

rm -rf ../../../part_4_test_in_aws_environment/.mysql_dns ../../../part_4_test_in_aws_environment/.spark_dns ../../../part_4_test_in_aws_environment/.spark_elb_dns ../../../part_4_test_in_aws_environment/.testrunner_dns ../../../part_4_test_in_aws_environment/.wiremock_dns

cd ../../..
