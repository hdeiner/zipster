#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# We'll need java sdk and maven
sudo apt-get install default-jdk -y
sudo apt install maven -y

# We'll need Vault
sudo apt-get install unzip -y
curl -O https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip
unzip vault_1.3.0_linux_amd64.zip
sudo mv vault /usr/local/bin/.

echo "Register with Vault"
uuidgen > .container.testrunner.uuid
vault login -address="http://$(<.vault_dns):8200" $(<.vault_initial_root_token)
vault kv put -address="http://$(<.vault_dns):8200" UUIDS/$(<.container.testrunner.uuid) environment=$(<.environment)
vault kv put -address="http://$(<.vault_dns):8200" ENVIRONMENTS/$(<.environment)/TESTRUNNER uuid=$(<.container.testrunner.uuid) endpoint=http://$(<.testrunner_dns)