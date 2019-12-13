#!/usr/bin/env bash

figlet -w 160 -f standard "Verify in vault-mysql-wiremock-zipster Environment"

cd ..
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_WireMock.feature"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature"
cd -

