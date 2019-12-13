#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# Install Docker
sudo apt-get -qq install -y docker-ce

echo "Start the Zipster (Spark) server"
sudo docker network create -d bridge mynetwork
sudo docker run -d -p 9002:9002 -v $(pwd)/tmp/config/zipster:/tmp/config/zipster --network=mynetwork --name zipster howarddeiner/zipster-spark
sudo docker cp /tmp/config/zipster/environment zipster:/tmp/config/zipster/environment
sudo docker cp /tmp/config/zipster/vault_addr zipster:/tmp/config/zipster/vault_addr
sudo docker cp /tmp/config/zipster/vault_token zipster:/tmp/config/zipster/vault_token

while true ; do
  result=$(sudo docker logs zipster 2>&1 | grep -c "INFO org.eclipse.jetty.server.Server - Started")
  if [ $result != 0 ] ; then
    echo "Zipster has started"
    break
  fi
  sleep 5
done

