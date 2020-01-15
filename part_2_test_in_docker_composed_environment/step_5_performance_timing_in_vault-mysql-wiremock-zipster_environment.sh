#!/usr/bin/env bash

figlet -w 160 -f standard "Performance Timing in vault-mysql-wiremock-zipster Environment"

cd ..

start=$SECONDS
echo "Starting 1 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 1 tests: $((end-start)) seconds."

echo "Starting 2 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 2 tests: $((end-start)) seconds."

echo "Starting 3 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 3 tests: $((end-start)) seconds."

echo "Starting 4 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 4 tests: $((end-start)) seconds."

echo "Starting 5 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 5 tests: $((end-start)) seconds."

echo "Starting 6 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 6 tests: $((end-start)) seconds."

cd