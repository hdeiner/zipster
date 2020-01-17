#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Wiremock in AWS"

#export ENVIRONMENT=$(echo `cat .environment`)
#echo "ENVIRONMENT at "$ENVIRONMENT

#export WIREMOCK_DNS=$(echo `cat .wiremock_dns`)
#echo "WIREMOCK at "$WIREMOCK_DNS

#figlet -w 160 -f slant "Upload "$ENVIRONMENT" configuration"
#echo "upload: ../.environment to /home/ubuntu/.environment"
#bolt file upload '../.environment' '/home/ubuntu/.environment' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../.vault_dns to /home/ubuntu/.vault_dns"
#bolt file upload '../.vault_dns' '/home/ubuntu/.vault_dns' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../.vault_initial_root_token to /home/ubuntu/.vault_initial_root_token"
#bolt file upload '../.vault_initial_root_token' '/home/ubuntu/.vault_initial_root_token' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: ../.wiremock_dns to /home/ubuntu/.wiremock_dns"
#bolt file upload '../.wiremock_dns' '/home/ubuntu/.wiremock_dns' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check

#figlet -w 160 -f slant "Upload wiremock configuration"
#echo "remote execution: rm -rf /home/ubuntu/wiremock"
#bolt command run 'rm -rf /home/ubuntu/wiremock' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "remote execution: mkdir /home/ubuntu/wiremock"
#bolt command run 'mkdir /home/ubuntu/wiremock' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "upload: wiremock configuration to /home/ubuntu/wiremock"
#bolt file upload '../wiremock' '/home/ubuntu/wiremock' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check

#figlet -w 160 -f slant "Upload and run provision_wiremock.sh"
#figlet -w 160 -f slant "Remote execution of provision_wiremock.sh"
#echo "upload: provisioning_scripts/provision_wiremock.sh to /home/ubuntu/provision_wiremock.sh"
#bolt file upload 'provisioning_scripts/provision_wiremock.sh' '/home/ubuntu/provision_wiremock.sh' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "remote execution: chmod +x /home/ubuntu/provision_wiremock.sh"
#bolt command run 'chmod +x /home/ubuntu/provision_wiremock.sh' --targets $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
#echo "remote exeution: /home/ubuntu/provision_wiremock.sh"
bolt command run '/home/ubuntu/provision_wiremock.sh' --targets $(<.wiremock_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null
