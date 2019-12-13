#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# Install Docker
sudo apt-get -qq install -y docker-ce

echo "Start the Wiremock server"
sudo docker network create -d bridge mynetwork
sudo docker run -d -p 9001:8080 -v $(pwd)/wiremock/wiremock:/home/wiremock --network=mynetwork --name wiremock rodolpheche/wiremock

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

