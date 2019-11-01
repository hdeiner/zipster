#!/usr/bin/env bash

figlet -w 160 -f standard "Local Verification"

figlet -w 160 -f small "Starting  WireMock, MySQL, and Zipster"
docker-compose -f docker-compose-local-verification.yml up -d

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
  curl -s -d "{\"radius\": \"2.0\",\"zipcode\":\"07440\"}" -H "Content-Type: application/json" -X POST localhost:9002/zipster > temp.txt
  result=$(grep -c "distance" temp.txt)
  if [ $result = 3 ] ; then
    echo "Zipster has started"
    break
  fi
  sleep 5
done
rm temp.txt

figlet -w 160 -f small "Run Local Verification Tests"

mvn test

figlet -w 160 -f small "Shut Down WireMock, MySQL, and Zipster"

docker-compose -f docker-compose-local-verification.yml down