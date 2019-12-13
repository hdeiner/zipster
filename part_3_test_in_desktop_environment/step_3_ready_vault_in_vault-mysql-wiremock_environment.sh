#!/usr/bin/env bash

figlet -w 160 -f standard "Ready Vault for DESKTOP Environment"

echo "Register WireMock"
uuidgen > .container.wiremock.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.wiremock.uuid) environment=DESKTOP > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DESKTOP/WIREMOCK uuid=$(<.container.wiremock.uuid) endpoint=http://localhost:9001/zipster > /dev/null

echo "Register MySQL"
uuidgen > .container.mysql.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.mysql.uuid) environment=DESKTOP > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DESKTOP/MYSQL uuid=$(<.container.mysql.uuid) url=jdbc:mysql://localhost:3306/zipster?useSSL=false user=root password=password > /dev/null

echo "Register Zipster"
uuidgen > .container.zipster.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.zipster.uuid) environment=DOCKER_COMPOSED > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DESKTOP/ZIPSTER uuid=$(<.container.zipster.uuid) endpoint=http://localhost:9002/zipster > /dev/null

rm .container.wiremock.uuid .container.mysql.uuid .container.zipster.uuid

echo "DESKTOP" > /tmp/config/zipster/environment
echo "localhost" > /tmp/config/zipster/vault_addr
cp ./.vault_root_token  /tmp/config/zipster/vault_token

