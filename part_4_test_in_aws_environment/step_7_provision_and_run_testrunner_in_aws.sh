#!/usr/bin/env bash

figlet -w 160 -f standard "Provision and Run Tests in AWS_DEMO"

#export ENVIRONMENT=$(echo `cat .environment`)
#echo "ENVIRONMENT at "$ENVIRONMENT

export TESTRUNNER_DNS=$(echo `cat .testrunner_dns`)
echo "TESTRUNNER at "$TESTRUNNER_DNS

#figlet -w 160 -f slant "Upload "$ENVIRONMENT" configuration"
#echo "upload: .environment to /home/ubuntu/.environment"
#bolt file upload '.environment' '/home/ubuntu/.environment' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: .vault_dns to /home/ubuntu/.vault_dns"
#bolt file upload '.vault_dns' '/home/ubuntu/.vault_dns' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: .vault_initial_root_token to /home/ubuntu/.vault_initial_root_token"
#bolt file upload '.vault_initial_root_token' '/home/ubuntu/.vault_initial_root_token' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: .testrunner_dns to /home/ubuntu/.testrunner_dns"
#bolt file upload '.testrunner_dns' '/home/ubuntu/.testrunner_dns' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check

#figlet -w 160 -f slant "Provision Vault information"
#echo "remote execution: mkdir -p /tmp/config/zipster"
#bolt command run 'mkdir -p /tmp/config/zipster' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: .environment to /tmp/config/zipster/environment"
#bolt file upload '.environment' '/tmp/config/zipster/environment' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: .vault_dns to /tmp/config/zipster/vault_addr"
#bolt file upload '.vault_dns' '/tmp/config/zipster/vault_addr' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: .vault_initial_root_token to /tmp/config/zipster/vault_token"
#bolt file upload '.vault_initial_root_token' '/tmp/config/zipster/vault_token' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check

figlet -w 160 -f slant "Upload test code"
echo "upload: ../pom.xml to /home/ubuntu/pom.xml"
bolt file upload '../pom.xml' '/home/ubuntu/pom.xml' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../src to /home/ubuntu/src"
bolt file upload '../src' '/home/ubuntu/src' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check

figlet -w 160 -f slant "Remote execution of provision_testrunner.sh"
#echo "upload: provisioning_scripts/provision_testrunner.sh to /home/ubuntu/provision_testrunner.sh"
#bolt file upload 'provisioning_scripts/provision_testrunner.sh' '/home/ubuntu/provision_testrunner.sh' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "remote execution: chmod +x /home/ubuntu/provision_testrunner.sh"
#bolt command run 'chmod +x /home/ubuntu/provision_testrunner.sh' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "remote exeution: /home/ubuntu/provision_testrunner.sh"
bolt command run '/home/ubuntu/provision_testrunner.sh' --targets $(<.testrunner_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null

figlet -w 160 -f slant "Remote execution of run_testrunner.sh"
#echo "upload: provisioning_scripts/run_testrunner.sh to /home/ubuntu/run_testrunner.sh"
#bolt file upload 'provisioning_scripts/run_testrunner.sh' '/home/ubuntu/run_testrunner.sh' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "remote execution: chmod +x /home/ubuntu/run_testrunner.sh"
#bolt command run 'chmod +x /home/ubuntu/run_testrunner.sh' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
#echo "remote exeution: /home/ubuntu/run_testrunner.sh"
bolt command run '/home/ubuntu/run_testrunner.sh' --targets $(<.testrunner_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null