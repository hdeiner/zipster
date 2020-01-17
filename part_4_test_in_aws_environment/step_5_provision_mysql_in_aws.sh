#!/usr/bin/env bash

figlet -w 160 -f standard "Provision MySQL in AWS"

#export ENVIRONMENT=$(echo `cat .environment`)
#echo "ENVIRONMENT at "$ENVIRONMENT

#export MYSQL_DNS=$(echo `cat .mysql_dns`)
#echo "MYSQL at "$MYSQL_DNS

#figlet -w 160 -f slant "Upload "$ENVIRONMENT" configuration"
#echo "upload: ../.environment to /home/ubuntu/.environment"
#bolt file upload '../.environment' '/home/ubuntu/.environment' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../.vault_dns to /home/ubuntu/.vault_dns"
#bolt file upload '../.vault_dns' '/home/ubuntu/.vault_dns' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../.vault_initial_root_token to /home/ubuntu/.vault_initial_root_token"
#bolt file upload '../.vault_initial_root_token' '/home/ubuntu/.vault_initial_root_token' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../.mysql_dns to /home/ubuntu/.mysql_dns"
#bolt file upload '../.mysql_dns' '/home/ubuntu/.mysql_dns' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check

#figlet -w 160 -f slant "Upload and run provision_mysql.sh"
#figlet -w 160 -f slant "Remote execution of provision_mysql.sh"
#echo "upload: ../docker-compose-mysql-and-mysql-data.yml to /home/ubuntu/docker-compose-mysql-and-mysql-data.yml"
#bolt file upload '../docker-compose-mysql-and-mysql-data.yml' '/home/ubuntu/docker-compose-mysql-and-mysql-data.yml' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../mysql-data.tar.gz to /home/ubuntu/mysql-data.tar.gz"
#bolt file upload '../mysql-data.tar.gz' '/home/ubuntu/mysql-data.tar.gz' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: provisioning_scripts/provision_mysql.sh to /home/ubuntu/provision_mysql.sh"
#bolt file upload 'provisioning_scripts/provision_mysql.sh' '/home/ubuntu/provision_mysql.sh' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "remote execution: chmod +x /home/ubuntu/provision_mysql.sh"
#bolt command run 'chmod +x /home/ubuntu/provision_mysql.sh' --targets $MYSQL_DNS --user 'ubuntu' --no-host-key-check
#echo "remote exeution: /home/ubuntu/provision_mysql.sh"
bolt command run '/home/ubuntu/provision_mysql.sh' --targets $(<.mysql_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null