#!/usr/bin/env bash

figlet -w 160 -f standard "Terraform AWS Environment"

cd ../src/iac/terraform-vault-wiremock-mysql-spark-testrunner

terraform init
terraform apply -auto-approve

echo `terraform output mysql_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../.mysql_dns
echo `terraform output spark_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../.spark_dns
echo `terraform output testrunner_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../.testrunner_dns
echo `terraform output vault_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../.vault_dns
echo `terraform output wiremock_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../.wiremock_dns

cd ../../..