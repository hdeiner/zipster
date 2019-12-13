#!/usr/bin/env bash

figlet -w 160 -f standard "Run Tests in AWS_DEMO"

figlet -w 160 -f slant "Wire together the components in Vault"

export ENVIRONMENT=AWS_DEMO

echo "Authenticate to Vault"
export VAULT_DNS=$(echo `cat ../.vault_dns`)
echo "VAULT at "$VAULT_DNS
export VAULT_TOKEN=$(echo `cat ../.vault_initial_root_token`)
echo "VAULT_TOKEN is "$VAULT_TOKEN
vault login -address="http://$VAULT_DNS:8200" $VAULT_TOKEN

export WIREMOCK_DNS=$(echo `cat ../.wiremock_dns`)
echo "WIREMOCK at "$WIREMOCK_DNS

echo "Register WireMock to Vault"
uuidgen > .container.wiremock.uuid
vault kv put -address="http://$VAULT_DNS:8200" UUIDS/$(<.container.wiremock.uuid) environment=$ENVIRONMENT > /dev/null
vault kv put -address="http://$VAULT_DNS:8200" ENVIRONMENTS/$ENVIRONMENT/WIREMOCK uuid=$(<.container.wiremock.uuid) endpoint=http://$WIREMOCK_DNS:9001/zipster > /dev/null

export MYSQL_DNS=$(echo `cat ../.mysql_dns`)
echo "MYSQL at "$MYSQL_DNS

echo "Register MySQL to Vault"
uuidgen > .container.mysql.uuid
vault kv put -address="http://$VAULT_DNS:8200" UUIDS/$(<.container.mysql.uuid) environment=$ENVIRONMENT > /dev/null
vault kv put -address="http://$VAULT_DNS:8200" ENVIRONMENTS/$ENVIRONMENT/MYSQL uuid=$(<.container.mysql.uuid) url=jdbc:mysql://$MYSQL_DNS:3306/zipster?useSSL=false user=root password=password > /dev/null

export SPARK_DNS=$(echo `cat ../.spark_dns`)
echo "SPARK at "$SPARK_DNS

echo "Register Zipster to Vault"
uuidgen > .container.zipster.uuid
vault kv put -address="http://$VAULT_DNS:8200" UUIDS/$(<.container.zipster.uuid) environment=$ENVIRONMENT > /dev/null
vault kv put -address="http://$VAULT_DNS:8200" ENVIRONMENTS/$ENVIRONMENT/ZIPSTER uuid=$(<.container.zipster.uuid) endpoint=http://$SPARK_DNS:9002/zipster > /dev/null

export TESTRUNNER_DNS=$(echo `cat ../.testrunner_dns`)
echo "TESTRUNNER at "$TESTRUNNER_DNS

echo "Register Testrunner to Vault"
uuidgen > .container.testrunner.uuid
vault kv put -address="http://$VAULT_DNS:8200" UUIDS/$(<.container.testrunner.uuid) environment=$ENVIRONMENT > /dev/null
vault kv put -address="http://$VAULT_DNS:8200" ENVIRONMENTS/$ENVIRONMENT/TESTRUNNER uuid=$(<.container.testrunner.uuid) endpoint=$TESTRUNNER_DNS > /dev/null

rm .container.wiremock.uuid .container.mysql.uuid .container.zipster.uuid .container.testrunner.uuid

echo $ENVIRONMENT > .environment

figlet -w 160 -f slant "Provision Vault information"
echo "remote execution: mkdir -p /tmp/config/zipster"
bolt command run 'mkdir -p /tmp/config/zipster' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "upload: .environment to /tmp/config/zipster/environment"
bolt file upload '.environment' '/tmp/config/zipster/environment' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../.vault_dns to /tmp/config/zipster/vault_addr"
bolt file upload '../.vault_dns' '/tmp/config/zipster/vault_addr' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../.vault_initial_root_token to /tmp/config/zipster/vault_token"
bolt file upload '../.vault_initial_root_token' '/tmp/config/zipster/vault_token' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check

rm .environment

figlet -w 160 -f slant "Upload test code"
echo "upload: ../pom.xml to /home/ubuntu/pom.xml"
bolt file upload '../pom.xml' '/home/ubuntu/pom.xml' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../src to /home/ubuntu/src"
bolt file upload '../src' '/home/ubuntu/src' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check

figlet -w 160 -f slant "Upload and run provision_and_run_testrunner.sh"
echo "upload: provisioning_scripts/provision_and_run_testrunner.sh to /home/ubuntu/provision_and_run_testrunner.sh"
bolt file upload 'provisioning_scripts/provision_and_run_testrunner.sh' '/home/ubuntu/provision_and_run_testrunner.sh' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: chmod +x /home/ubuntu/provision_and_run_testrunner.sh"
bolt command run 'chmod +x /home/ubuntu/provision_and_run_testrunner.sh' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "remote exeution: /home/ubuntu/provision_and_run_testrunner.sh"
bolt command run '/home/ubuntu/provision_and_run_testrunner.sh' --nodes $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check | tee ./.temp

rm ./.temp