#!/usr/bin/env bash

figlet -w 160 -f standard "Verify in vault-mysql-wiremock Environment"

echo "DESKTOP" > /tmp/config/zipster/environment
echo "http://localhost:8200" > /tmp/config/zipster/vault_addr
cp ./.vault_root_token  /tmp/config/zipster/vault_token

java -jar target/zipster-1.0-SNAPSHOT-jar-with-dependencies.jar&
sleep 10

mvn test

kill $(pgrep -f zipster-1.0-SNAPSHOT-jar-with-dependencies.jar)