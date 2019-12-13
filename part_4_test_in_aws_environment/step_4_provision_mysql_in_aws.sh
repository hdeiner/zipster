#!/usr/bin/env bash

figlet -w 160 -f standard "Provision MySQL in AWS"

export MYSQL_DNS=$(echo `cat ../.mysql_dns`)
echo "MYSQL at "$MYSQL_DNS

figlet -w 160 -f slant "Upload FlyWay"
echo "upload: flyway-commandline-4.2.0-linux-x64.tar.gz to /homw/ubuntu/flyway-commandline-4.2.0-linux-x64.tar.gz"
bolt file upload '../flyway-commandline-4.2.0-linux-x64.tar.gz' '/home/ubuntu/flyway-commandline-4.2.0-linux-x64.tar.gz' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: tar -xvf flyway-commandline-4.2.0-linux-x64.tar.gz"
bolt command run 'tar -xvf flyway-commandline-4.2.0-linux-x64.tar.gz' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: flyway.conf to /home/ubuntu/flyway-4.2.0/conf/flyway.conf"
bolt file upload '../flyway-4.2.0/conf/flyway.conf' '/home/ubuntu/flyway-4.2.0/conf/flyway.conf' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: mysql-connector-java-8.0.18.jar to /home/ubuntu/flyway-4.2.0/drivers/mysql-connector-java-8.0.18.jar"
bolt file upload '../flyway-4.2.0/drivers/mysql-connector-java-8.0.18.jar' '/home/ubuntu/flyway-4.2.0/drivers/mysql-connector-java-8.0.18.jar' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: V1_1__Zipcode_Schema.sql to /home/ubuntu/flyway-4.2.0/sql/V1_1__Zipcode_Schema.sql"
bolt file upload '../flyway-4.2.0/sql/V1_1__Zipcode_Schema.sql' '/home/ubuntu/flyway-4.2.0/sql/V1_1__Zipcode_Schema.sql' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: V1_1__Zipcode_Data.sql to /home/ubuntu/flyway-4.2.0/sql/V1_2__Zipcode_Data.sql"
bolt file upload '../flyway-4.2.0/sql/V1_2__Zipcode_Data.sql' '/home/ubuntu/flyway-4.2.0/sql/V1_2__Zipcode_Data.sql' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "upload: V2_1__Add_Spatial_Data.sql to /home/ubuntu/flyway-4.2.0/sql/V2_1__Add_Spatial_Data.sql"
bolt file upload '../flyway-4.2.0/sql/V2_1__Add_Spatial_Data.sql' '/home/ubuntu/flyway-4.2.0/sql/V2_1__Add_Spatial_Data.sql' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check

figlet -w 160 -f slant "Upload and run provision_mysql.sh"
echo "upload: provisioning_scripts/provision_mysql.sh to /home/ubuntu/provision_mysql.sh"
bolt file upload 'provisioning_scripts/provision_mysql.sh' '/home/ubuntu/provision_mysql.sh' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: chmod +x /home/ubuntu/provision_mysql.sh"
bolt command run 'chmod +x /home/ubuntu/provision_mysql.sh' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check
echo "remote exeution: /home/ubuntu/provision_mysql.sh"
bolt command run '/home/ubuntu/provision_mysql.sh' --nodes $MYSQL_DNS --user 'ubuntu' --no-host-key-check | tee ./.temp