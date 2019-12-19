#!/usr/bin/env bash

figlet -w 160 -f standard "Verify in vault-mysql-wiremock Environment"

cd ..
java -jar target/zipster-1.0-SNAPSHOT-jar-with-dependencies.jar&
sleep 10

mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_WireMock.feature"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature"

cd -

kill $(pgrep -f zipster-1.0-SNAPSHOT-jar-with-dependencies.jar)
