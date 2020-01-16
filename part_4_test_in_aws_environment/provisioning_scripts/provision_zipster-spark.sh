#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# Install Docker
sudo apt-get -qq install -y docker-ce

# We'll need Vault
sudo apt-get install unzip -y
curl -O https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip
unzip vault_1.3.0_linux_amd64.zip
sudo mv vault /usr/local/bin/.

echo "Start the Zipster (Spark) server"
sudo docker network create -d bridge mynetwork
sudo docker run -d -p 9002:9002 -v $(pwd)/tmp/config/zipster:/tmp/config/zipster --network=mynetwork --name zipster howarddeiner/zipster-spark
mkdir -p /tmp/config/zipster
sudo docker cp .environment zipster:/tmp/config/zipster/environment
sudo docker cp .vault_dns zipster:/tmp/config/zipster/vault_addr
sudo docker cp .vault_initial_root_token zipster:/tmp/config/zipster/vault_token

while true ; do
  result=$(sudo docker logs zipster 2>&1 | grep -c "INFO org.eclipse.jetty.server.Server - Started")
  if [ $result != 0 ] ; then
    echo "Zipster has started"
    break
  fi
  sleep 5
done

echo "Register with Vault"
uuidgen > .container.zipster.uuid
vault login -address="http://$(<.vault_dns):8200" $(<.vault_initial_root_token)
vault kv put -address="http://$(<.vault_dns):8200" UUIDS/$(<.container.zipster.uuid) environment=$(<.environment)
vault kv put -address="http://$(<.vault_dns):8200" ENVIRONMENTS/$(<.environment)/ZIPSTER_INSTANCE_$(<.container.zipster.uuid) uuid=$(<.container.zipster.uuid) endpoint=http://$(<.spark_dns):9002/zipster load_balanced_endpoint=http://$(<.spark_elb_dns):9002/zipster
