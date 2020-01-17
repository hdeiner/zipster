#!/usr/bin/env bash

figlet -w 160 -f standard "Teardown AWS Vault Environment"

cd ../src/iac/terraform-vault

terraform destroy -auto-approve

rm -rf ../../../part_4_test_in_aws_environment/.environment ../../../part_4_test_in_aws_environment/.vault_dns ../../../part_4_test_in_aws_environment/.vault_initial_root_token

cd ../../..
