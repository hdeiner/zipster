#!/usr/bin/env bash

mvn -q clean compile
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_WireMock.feature"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature"

# Run performance tests
start=$SECONDS
echo "Starting 1 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 1 tests: $((end-start)) seconds."

start=$SECONDS
echo "Starting 2 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 2 tests: $((end-start)) seconds."

start=$SECONDS
echo "Starting 3 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 3 tests: $((end-start)) seconds."

start=$SECONDS
echo "Starting 4 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 4 tests: $((end-start)) seconds."

start=$SECONDS
echo "Starting 5 simultaneous tests"
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
mvn -q test -Dcucumber.options="src/test/java/com/deinersoft/zipster/resources/features/Zipster_Concrete.feature" >> /dev/null &
wait < <(jobs -p)
end=$SECONDS
echo "Duration for 5 tests: $((end-start)) seconds."

start=$SECONDS
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