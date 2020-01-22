#!/usr/bin/env bash

figlet -w 160 -f standard "Provision Wiremock in AWS"

bolt command run '/home/ubuntu/provision_wiremock.sh' --targets $(<.wiremock_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null
