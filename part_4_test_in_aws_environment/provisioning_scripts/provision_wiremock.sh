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

echo "Register with Vault"
uuidgen > .container.wiremock.uuid
vault login -address="http://$(<.vault_dns):8200" $(<.vault_initial_root_token)
vault kv put -address="http://$(<.vault_dns):8200" UUIDS/$(<.container.wiremock.uuid) environment=$(<.environment)
vault kv put -address="http://$(<.vault_dns):8200" ENVIRONMENTS/$(<.environment)/WIREMOCK uuid=$(<.container.wiremock.uuid) endpoint=http://$(<.wiremock_dns):9001/zipster
