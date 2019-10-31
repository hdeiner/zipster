#!/usr/bin/env bash

figlet -w 160 -f standard "Local Verification"

figlet -w 160 -f small "Starting WireMock"
docker-compose -f docker-compose-wiremock.yml up -d

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

figlet -w 160 -f small "Run WireMock Tests"

mvn test

figlet -w 160 -f small "Shut Down WireMock"

docker-compose -f docker-compose-wiremock.yml down