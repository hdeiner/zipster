#!/usr/bin/env bash

figlet -w 160 -f standard "Dockerize zipster-spark"

figlet -w 160 -f small "Clean, Compile, and Jar"

mvn clean compile

figlet -w 160 -f small "Build Docker Image"

docker rmi howarddeiner/zipster-spark

cp target/zipster-1.0-SNAPSHOT-jar-with-dependencies.jar src/iac/docker-spark/zipster-1.0-SNAPSHOT-jar-with-dependencies.jar
cp /usr/local/bin/vault src/iac/docker-spark/vault

docker build src/iac/docker-spark -t howarddeiner/zipster-spark

rm src/iac/docker-spark/zipster-1.0-SNAPSHOT-jar-with-dependencies.jar
rm src/iac/docker-spark/vault