#!/usr/bin/env bash

# First, add the GPG key for the official Docker repository to the system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Next, update the package database with the Docker packages from the newly added repo:
sudo apt-get -qq update

# We'll need java sdk and maven
sudo apt-get install default-jdk -y
sudo apt install maven -y

# We'll also need Vault
sudo apt-get install unzip -y
curl -O https://releases.hashicorp.com/vault/1.3.0/vault_1.3.0_linux_amd64.zip
unzip vault_1.3.0_linux_amd64.zip
sudo mv vault /usr/local/bin/.

# Run the tests!
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
