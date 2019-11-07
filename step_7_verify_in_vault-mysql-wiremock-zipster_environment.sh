#!/usr/bin/env bash

figlet -w 160 -f standard "Verify in vault-mysql-wiremock-zipster Environment"

echo "DOCKER_COMPOSED" > /tmp/config/zipster/environment
echo "http://vault:8200" > /tmp/config/zipster/vault_addr
cp ./.vault_root_token  /tmp/config/zipster/vault_token

mvn test

