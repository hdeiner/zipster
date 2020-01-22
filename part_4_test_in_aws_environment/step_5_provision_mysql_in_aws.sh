#!/usr/bin/env bash

figlet -w 160 -f standard "Provision MySQL in AWS"

bolt command run '/home/ubuntu/provision_mysql.sh' --targets $(<.mysql_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null