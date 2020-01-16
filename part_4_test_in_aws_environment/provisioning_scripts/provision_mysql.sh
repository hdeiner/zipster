#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# Install Docker
sudo apt-get -qq install -y docker-ce

# Install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install mysql client
sudo apt install -y mysql-client

# We'll need Vault
sudo apt-get install unzip -y
curl -O https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip
unzip vault_1.3.0_linux_amd64.zip
sudo mv vault /usr/local/bin/.

echo "Start the Mysql server"
sudo tar -xf mysql-data.tar.gz
sudo docker-compose -f ./docker-compose-mysql-and-mysql-data.yml up -d

while true ; do
  result=$(sudo docker logs mysql 2>&1 | grep -c "Version: '5.7.28'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)")
  if [ $result != 0 ] ; then
    echo "MySQL has started"
    break
  fi
  sleep 5
done

echo "Register with Vault"
uuidgen > .container.mysql.uuid
vault login -address="http://$(<.vault_dns):8200" $(<.vault_initial_root_token)
vault kv put -address="http://$(<.vault_dns):8200" UUIDS/$(<.container.mysql.uuid) environment=$(<.environment)
vault kv put -address="http://$(<.vault_dns):8200" ENVIRONMENTS/$(<.environment)/MYSQL uuid=$(<.container.mysql.uuid) url=jdbc:mysql://$(<.mysql_dns):3306/zipster?useSSL=false user=root password=password
