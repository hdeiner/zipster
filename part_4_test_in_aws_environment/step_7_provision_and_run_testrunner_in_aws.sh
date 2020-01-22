#!/usr/bin/env bash

figlet -w 160 -f standard "Provision and Run Tests in AWS_DEMO"

#export ENVIRONMENT=$(echo `cat .environment`)
#echo "ENVIRONMENT at "$ENVIRONMENT

export TESTRUNNER_DNS=$(echo `cat .testrunner_dns`)
echo "TESTRUNNER at "$TESTRUNNER_DNS

figlet -w 160 -f slant "Upload test code"
echo "upload: ../pom.xml to /home/ubuntu/pom.xml"
bolt file upload '../pom.xml' '/home/ubuntu/pom.xml' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check
echo "upload: ../src to /home/ubuntu/src"
bolt file upload '../src' '/home/ubuntu/src' --targets $TESTRUNNER_DNS --user 'ubuntu' --no-host-key-check

figlet -w 160 -f slant "Remote execution of provision_testrunner.sh"
bolt command run '/home/ubuntu/provision_testrunner.sh' --targets $(<.testrunner_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null

figlet -w 160 -f slant "Remote execution of run_testrunner.sh"
bolt command run '/home/ubuntu/run_testrunner.sh' --targets $(<.testrunner_dns) --user 'ubuntu' --no-host-key-check | tee /dev/null