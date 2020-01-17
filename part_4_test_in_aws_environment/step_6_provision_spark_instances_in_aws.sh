#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Spark Instances in AWS"

#export ENVIRONMENT=$(echo `cat .environment`)
#echo "ENVIRONMENT at "$ENVIRONMENT

#export SPARK_ELB_DNS=$(echo `cat .spark_elb_dns`)
#echo "SPARK_ELB_DNS at "$SPARK_ELB_DNS

#export SPARK_DNS_INSTANCES=$(echo `cat .spark_dns`)
#echo "SPARK_DNS_INSTANCES at "$SPARK_DNS_INSTANCES

#figlet -w 160 -f slant "Provisioning Instances"

#for SPARK_DNS in $SPARK_DNS_INSTANCES; do
#    figlet -w 180 -f small "Provisioning Instance " $SPARK_DNS
#    echo $SPARK_DNS > .spark_dns_instance
#    echo "upload: ../.environment to /home/ubuntu/.environment"
#    bolt file upload '../.environment' '/home/ubuntu/.environment' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    echo "upload: ../.vault_dns to /home/ubuntu/.vault_dns"
#    bolt file upload '../.vault_dns' '/home/ubuntu/.vault_dns' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    echo "upload: ../.vault_initial_root_token to /home/ubuntu/.vault_initial_root_token"
#    bolt file upload '../.vault_initial_root_token' '/home/ubuntu/.vault_initial_root_token' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    echo "upload: .spark_elb_dns to /home/ubuntu/.spark_elb_dns"
#    bolt file upload '.spark_elb_dns' '/home/ubuntu/.spark_elb_dns' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    echo "upload: .spark_dns_instance to /home/ubuntu/.spark_dns"
#    bolt file upload '.spark_dns_instance' '/home/ubuntu/.spark_dns' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    rm ../.spark_dns_instance

#    echo "upload: provisioning_scripts/provision_zipster-spark.sh to /home/ubuntu/provision_zipster-spark.sh"
#    bolt file upload 'provisioning_scripts/provision_zipster-spark.sh' '/home/ubuntu/provision_zipster-spark.sh' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    echo "remote execution: chmod +x /home/ubuntu/provision_zipster-spark.sh"
#    bolt command run 'chmod +x /home/ubuntu/provision_zipster-spark.sh' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check
#    echo "remote exeution: /home/ubuntu/provision_zipster-spark.sh"
#    bolt command run '/home/ubuntu/provision_zipster-spark.sh' --targets $SPARK_DNS --user 'ubuntu' --no-host-key-check | tee ./.tempdone
#done

cat .spark_dns | sed -r 's/[ ]+/,/g' > .spark_dns_commas
echo "Use bolt to provision "$(<.spark_dns_commas)
bolt command run '/home/ubuntu/provision_zipster-spark.sh' --targets $(<.spark_dns_commas) --user 'ubuntu' --no-host-key-check | tee /dev/null
rm .spark_dns_commas

echo "Tell Vault about where the SPARK Elastic Load Balancer is located"
vault login -address="http://$(<.vault_dns):8200" $(<.vault_initial_root_token)
vault kv put -address="http://$(<.vault_dns):8200" ENVIRONMENTS/$(<.environment)/ZIPSTER endpoint=http://$(<.spark_elb_dns):9002/zipster
