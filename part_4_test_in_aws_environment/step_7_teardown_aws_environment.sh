#!/usr/bin/env bash

figlet -w 160 -f standard "Teardown AWS Environment"

cd ../src/iac/terraform-vault-wiremock-mysql-spark-testrunner

terraform destroy -auto-approve

rm -rf ../../../.mysql_dns ../../../.spark_dns ../../../.testrunner_dns ../../../.vault_dns ../../../.wiremock_dns ../../../.vault_initial_root_token

cd ../../..