#!/usr/bin/env bash

figlet -w 160 -f standard "Provision MySQL in AWS"

export MYSQL_DNS=$(echo `cat ../.mysql_dns`)
echo "MYSQL at "$MYSQL_DNS

figlet -w 160 -f slant "Upload and run provision_mysql.sh"
echo "upload: ../docker-compose-mysql-and-mysql-data.yml to /home/ubuntu/docker-compose-mysql-and-mysql-data.yml"
bolt file upload '../docker-compose-mysql-and-mysql-data.yml' '/home/ubuntu/docker-compose-mysql-and-mysql-data.yml' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../mysql-data.tar.gz to /home/ubuntu/mysql-data.tar.gz"
bolt file upload '../mysql-data.tar.gz' '/home/ubuntu/mysql-data.tar.gz' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: provisioning_scripts/provision_mysql.sh to /home/ubuntu/provision_mysql.sh"
bolt file upload 'provisioning_scripts/provision_mysql.sh' '/home/ubuntu/provision_mysql.sh' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: chmod +x /home/ubuntu/provision_mysql.sh"
bolt command run 'chmod +x /home/ubuntu/provision_mysql.sh' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "remote exeution: /home/ubuntu/provision_mysql.sh"
bolt command run '/home/ubuntu/provision_mysql.sh' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check | tee ./.temp