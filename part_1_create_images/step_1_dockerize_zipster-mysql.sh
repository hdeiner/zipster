#!/usr/bin/env bash

figlet -w 160 -f standard "Dockerize zipster-mysql"

figlet -w 160 -f small "Create MySQL Data Container"
#docker rmi -f howarddeiner/zipster-mysql-data
#docker build src/iac/docker-mysql-data/ -t howarddeiner/zipster-mysql-data

figlet -w 160 -f small "Bring Up MySQL Continer"
docker volume rm zipster_zipster-mysql-data
docker-compose -f docker-compose-mysql.yml up -d

figlet -w 160 -f small "Wait for MySQL to Start"
while true ; do
  result=$(docker logs mysql 2>&1 | grep -c "Version: '5.7.28'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)")
  if [ $result != 0 ] ; then
    echo "MySQL has started"
    break
  fi
  sleep 5
done

figlet -w 160 -f small "Ready MySQL for FlyWay"
echo "CREATE USER 'FLYWAY' IDENTIFIED BY 'FLWAY';" | mysql -h 127.0.0.1 -P 3306 -u root --password=password  zipster > /dev/null

figlet -w 160 -f small "Create Our Database"
../flyway-4.2.0/flyway info
../flyway-4.2.0/flyway migrate
../flyway-4.2.0/flyway info

figlet -w 160 -f small "Bring Down MySQL Continer"
docker-compose -f docker-compose-mysql.yml down

#figlet -w 160 -f standard "Create zipster-mysql Image"

#figlet -w 160 -f small "Commit and Push the MySQL Data Container to Store the Image"
#docker stop mysql-data
#docker rmi -f howarddeiner/zipster-mysql-data
#docker commit mysql-data howarddeiner/zipster-mysql-data
#docker login
#docker push howarddeiner/zipster-mysql-data
#
#figlet -w 160 -f small "Commit and Push the MySQL Container to Store the Image"
#docker stop mysql
#docker rmi -f howarddeiner/zipster-mysql
#docker commit mysql howarddeiner/zipster-mysql
#docker login
#docker push howarddeiner/zipster-mysql
#
#figlet -w 160 -f small "Tear Down MySQL Container"
#docker-compose -f docker-compose-mysql.yml down
#
#sudo rm -rf ./mysql-data
