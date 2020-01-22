#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Spark Instances in AWS"

cat .spark_dns | sed -r 's/[ ]+/,/g' > .spark_dns_commas
echo "Use bolt to provision "$(<.spark_dns_commas)
bolt command run '/home/ubuntu/provision_zipster-spark.sh' --targets $(<.spark_dns_commas) --user 'ubuntu' --no-host-key-check | tee /dev/null
rm .spark_dns_commas

echo "Tell Vault about where the SPARK Elastic Load Balancer is located"
vault login -address="http://$(<.vault_dns):8200" $(<.vault_initial_root_token)
vault kv put -address="http://$(<.vault_dns):8200" ENVIRONMENTS/$(<.environment)/ZIPSTER endpoint=http://$(<.spark_elb_dns):9002/zipster
