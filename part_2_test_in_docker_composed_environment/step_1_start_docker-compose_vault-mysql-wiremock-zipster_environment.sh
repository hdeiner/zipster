#!/usr/bin/env bash

figlet -w 160 -f standard "Start docker-compose vault-mysql-wiremock-zipster Environment"

mkdir -p /tmp/config/zipster

touch /tmp/config/zipster/environment
touch /tmp/config/zipster/vault_addr
touch /tmp/config/zipster/vault_token

cd ..
sudo -S <<< "password" tar -xf mysql-data.tar.gz
cd -

docker-compose -f ../docker-compose-vault-mysql-wiremock-zipster.yml up -d

figlet -w 160 -f small "Wait for Vault to Start"
while true ; do
  result=$(docker logs vaultserver 2>&1 | grep -c "==> Vault server started! Log data will stream in below:")
  if [ $result != 0 ] ; then
    echo "Vault has started"
    break
  fi
  sleep 5
done

figlet -w 160 -f small "Wait for WireMock to start"

while true ; do
  curl -s -d "{\"radius\": \"2.0\",\"zipcode\":\"07440\"}" -H "Content-Type: application/json" -X POST localhost:9001/zipster > temp.txt
  result=$(grep -c "distance" temp.txt)
  if [ $result = 3 ] ; then
    echo "WireMock has started"
    break
  fi
  sleep 5
done
rm temp.txt

figlet -w 160 -f small "Wait for MySQL to Start"
while true ; do
  result=$(docker logs mysql 2>&1 | grep -c "Version: '5.7.28'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)")
  if [ $result != 0 ] ; then
    echo "MySQL has started"
    break
  fi
  sleep 5
done

figlet -w 160 -f small "Wait for Zipster to start"

while true ; do
  result=$(docker logs zipster 2>&1 | grep -c "INFO org.eclipse.jetty.server.Server - Started")
  if [ $result != 0 ] ; then
    echo "Zipster has started"
    break
  fi
  sleep 5
done
