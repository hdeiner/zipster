#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Zipster-Spark in AWS"

export ENVIRONMENT=AWS_DEMO

export SPARK_DNS=$(echo `cat ../.spark_dns`)
echo "SPARK at "$SPARK_DNS

figlet -w 160 -f slant "Provision Vault information"
echo $ENVIRONMENT > .environment
echo "remote execution: mkdir -p /tmp/config/zipster"
bolt command run 'mkdir -p /tmp/config/zipster' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check
echo "upload: .environment to /tmp/config/zipster/environment"
bolt file upload '.environment' '/tmp/config/zipster/environment' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../.vault_dns to /tmp/config/zipster/vault_addr"
bolt file upload '../.vault_dns' '/tmp/config/zipster/vault_addr' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../.vault_initial_root_token to /tmp/config/zipster/vault_token"
bolt file upload '../.vault_initial_root_token' '/tmp/config/zipster/vault_token' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check

rm .environment

figlet -w 160 -f slant "Upload and run provision_zipster-spark.sh"
echo "upload: provisioning_scripts/provision_zipster-spark.sh to /home/ubuntu/provision_zipster-spark.sh"
bolt file upload 'provisioning_scripts/provision_zipster-spark.sh' '/home/ubuntu/provision_zipster-spark.sh' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: chmod +x /home/ubuntu/provision_zipster-spark.sh"
bolt command run 'chmod +x /home/ubuntu/provision_zipster-spark.sh' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check
echo "remote exeution: /home/ubuntu/provision_zipster-spark.sh"
bolt command run '/home/ubuntu/provision_zipster-spark.sh' --nodes $SPARK_DNS --user 'ubuntu' --no-host-key-check | tee ./.temp