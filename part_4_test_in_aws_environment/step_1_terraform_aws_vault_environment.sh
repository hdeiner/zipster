#!/usr/bin/env bash

figlet -w 160 -f standard "Terraform AWS Vault Environment"

cd ../src/iac/terraform-vault

terraform init
terraform apply -auto-approve

echo `terraform output vault_dns | grep -o '".*"' | cut -d '"' -f2` > ../../../part_4_test_in_aws_environment/.vault_dns

cd ../../..