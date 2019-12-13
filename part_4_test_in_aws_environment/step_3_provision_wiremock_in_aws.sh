#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Wiremock in AWS"


export WIREMOCK_DNS=$(echo `cat ../.wiremock_dns`)
echo "WIREMOCK at "$WIREMOCK_DNS

figlet -w 160 -f slant "Upload wiremock configuration"
echo "remote execution: rm -rf /home/ubuntu/wiremock'"
bolt command run 'rm -rf /home/ubuntu/wiremock' --nodes $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: mkdir /home/ubuntu/wiremock"
bolt command run 'mkdir /home/ubuntu/wiremock' --nodes $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
echo "upload: wiremock configuration to /home/ubuntu/wiremock"
bolt file upload '../wiremock' '/home/ubuntu/wiremock' --nodes $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check

figlet -w 160 -f slant "Upload and run provision_wiremock.sh"
echo "upload: provisioning_scripts/provision_wiremock.sh to /home/ubuntu/provision_wiremock.sh"
bolt file upload 'provisioning_scripts/provision_wiremock.sh' '/home/ubuntu/provision_wiremock.sh' --nodes $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
echo "remote execution: chmod +x /home/ubuntu/provision_wiremock.sh"
bolt command run 'chmod +x /home/ubuntu/provision_wiremock.sh' --nodes $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check
echo "remote exeution: /home/ubuntu/provision_wiremock.sh"
bolt command run '/home/ubuntu/provision_wiremock.sh' --nodes $WIREMOCK_DNS --user 'ubuntu' --no-host-key-check | tee ./.temp
