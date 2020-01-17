#!/usr/bin/env bash

figlet -w 160 -f standard "Terraform AWS Wiremock MySQL Spark Testrunner Environment"

echo 'AWS_DEMO' > .environment

cd ../src/iac/terraform-wiremock-mysql-spark-testrunner

terraform init
terraform apply -auto-approve

echo `terraform output mysql_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../part_4_test_in_aws_environment/.mysql_dns
echo `terraform output spark_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../part_4_test_in_aws_environment/.spark_dns
echo `terraform output spark_elb_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../part_4_test_in_aws_environment/.spark_elb_dns
echo `terraform output testrunner_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../part_4_test_in_aws_environment/.testrunner_dns
echo `terraform output wiremock_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../part_4_test_in_aws_environment/.wiremock_dns

cd ../../..