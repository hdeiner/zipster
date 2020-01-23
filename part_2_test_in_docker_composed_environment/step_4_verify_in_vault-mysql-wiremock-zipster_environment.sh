#!/usr/bin/env bash

figlet -w 160 -f standard "Verify in vault-mysql-wiremock-zipster Environment"

figlet -w 160 -f small "Load Test Data Into Database"
../flyway-4.2.0/flyway info
../flyway-4.2.0/flyway -target=3_1 migrate
../flyway-4.2.0/flyway info

cd ..
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_WireMock.feature"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature"
cd -

