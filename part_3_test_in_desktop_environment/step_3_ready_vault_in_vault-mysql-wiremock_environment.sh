#!/usr/bin/env bash

figlet -w 160 -f standard "Ready Vault for DESKTOP Environment"

echo "Register WireMock"
uuidgen > .container.wiremock.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.wiremock.uuid) environment=DESKTOP > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DESKTOP/WIREMOCK uuid=$(<.container.wiremock.uuid) endpoint=localhost port=9001 > /dev/null

echo "Register MySQL"
uuidgen > .container.mysql.uuid
docker exec vaultserver vault kv put UUIDS/$(<.container.mysql.uuid) environment=DESKTOP > /dev/null
docker exec vaultserver vault kv put ENVIRONMENTS/DESKTOP/MYSQL uuid=$(<.container.mysql.uuid) url=jdbc:mysql://localhost:3306/zipster?useSSL=false user=root password=password > /dev/null

rm .container.wiremock.uuid .container.mysql.uuid

