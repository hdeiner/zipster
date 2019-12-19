#!/usr/bin/env bash

figlet -w 160 -f standard "Destroy docker-compose vault-mysql-wiremock-zipster Environment"

docker-compose -f ../docker-compose-vault-mysql-wiremock-zipster.yml down

rm -rf .vault_unsealkey_1 .vault_unsealkey_2 .vault_unsealkey_3 .vault_unsealkey_4 .vault_unsealkey_5 .vault_root_token /tmp/config/zipster
echo password | sudo rm -rf ../mysql-data