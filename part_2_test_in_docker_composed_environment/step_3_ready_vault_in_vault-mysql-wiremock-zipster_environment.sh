#!/usr/bin/env bash

figlet -w 160 -f standard "Ready Vault in vault-mysql-wiremock-zipster Environment"

echo "Register WireMock"
uuidgen > .container.wiremock.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.wiremock.uuid) environment=DOCKER_COMPOSED > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DOCKER_COMPOSED/WIREMOCK uuid=$(<.container.wiremock.uuid) endpoint=http://0.0.0.0:9001/zipster > /dev/null

echo "Register MySQL"
uuidgen > .container.mysql.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.mysql.uuid) environment=DOCKER_COMPOSED > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DOCKER_COMPOSED/MYSQL uuid=$(<.container.mysql.uuid) url=jdbc:mysql://mysql:3306/zipster?useSSL=false user=root password=password > /dev/null

echo "Register Zipster"
uuidgen > .container.zipster.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.zipster.uuid) environment=DOCKER_COMPOSED > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DOCKER_COMPOSED/ZIPSTER uuid=$(<.container.zipster.uuid) endpoint=http://0.0.0.0:9002/zipster > /dev/null

rm .container.wiremock.uuid .container.mysql.uuid .container.zipster.uuid

echo "DOCKER_COMPOSED" > /tmp/config/zipster/environment
echo "0.0.0.0" > /tmp/config/zipster/vault_addr
cp ./.vault_root_token  /tmp/config/zipster/vault_token