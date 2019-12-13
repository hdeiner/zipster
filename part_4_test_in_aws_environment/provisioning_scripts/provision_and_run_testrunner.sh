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

# We'll also need Vault
sudo apt-get install unzip -y
curl -O https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip
unzip vault_1.3.0_linux_amd64.zip
sudo mv vault /usr/local/bin/.

# Run the tests!
mvn -q clean compile
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_WireMock.feature"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature"
