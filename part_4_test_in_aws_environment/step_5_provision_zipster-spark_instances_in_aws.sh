#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Zipster-Spark Instances in AWS"

export ENVIRONMENT=AWS_DEMO

export SPARK_ELB_DNS=$(echo `cat ../.spark_elb_dns`)
echo "SPARK_ELB_DNS at "$SPARK_ELB_DNS


export SPARK_DNS_INSTANCES=$(echo `cat ../.spark_dns`)
echo "SPARK_DNS_INSTANCES at "$SPARK_DNS_INSTANCES

figlet -w 160 -f slant "Provisioning Instances"

for SPARK_DNS in $SPARK_DNS_INSTANCES; do
    figlet -w 180 -f small "Provisioning Instance " $SPARK_DNS
    echo $ENVIRONMENT > .environment
    echo "remote execution: mkdir -p /tmp/config/zipster"
    bolt command run 'mkdir -p /tmp/config/zipster' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
    echo "upload: .environment to /tmp/config/zipster/environment"
    bolt file upload '.environment' '/tmp/config/zipster/environment' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
    echo "upload: ../.vault_dns to /tmp/config/zipster/vault_addr"
    bolt file upload '../.vault_dns' '/tmp/config/zipster/vault_addr' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
    echo "upload: ../.vault_initial_root_token to /tmp/config/zipster/vault_token"
    bolt file upload '../.vault_initial_root_token' '/tmp/config/zipster/vault_token' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
    rm .environment
    echo "upload: provisioning_scripts/provision_zipster-spark.sh to /home/ubuntu/provision_zipster-spark.sh"
    bolt file upload 'provisioning_scripts/provision_zipster-spark.sh' '/home/ubuntu/provision_zipster-spark.sh' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
    echo "remote execution: chmod +x /home/ubuntu/provision_zipster-spark.sh"
    bolt command run 'chmod +x /home/ubuntu/provision_zipster-spark.sh' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
    echo "remote exeution: /home/ubuntu/provision_zipster-spark.sh"
    bolt command run '/home/ubuntu/provision_zipster-spark.sh' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check | tee ./.tempdone
done