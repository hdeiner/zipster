How to create and test a modern REST API in a server farm environment.

Let's say we want to design a REST API that can take a zipcode and a radius and return all the zipcodes within a certain number of miles to the given cente.

Architecturally, we will use the following framworks and tools:

- Java (for our code)
- Spark (for running a small REST server)
- MySQL (for persistence of a zipcode database)
- FlyWay (to version control the database)
- Wiremock (for designing and validating the API's contract)
- Cucumber for Java (to run our integration tests in)
    - locally in Docker containers (WireMock, Spark, MySQL).  Zipster server running on desktop.  Test code running on desktop.
    - locally in Docker containers (WireMock, Space, MySQL, Zipster)  Test code running on desktop.
    - in AWS cloud (using Terraform)
- Vault will also be a vital component of this project.  We will use it for holding together environments, the endpoints in those environments,and the secrets needed for those environments.

Explanation of the scripts to run:

1. step_1_dockerize_zipster-mysql.sh
    1. Bring up MySQL in a container
    1. Once MySQL starts, run FlyWay to establish schema and data
    1. Bring down the MySQL container
1. step_2_dockerize_zipster-spark.sh
    1. Build a clean jar for the server with all dependencies baked in
    1. Copy the built jar and the vault cli client for imcludion in the image
    1. Build the container from a custom Dockerfile 
1. step_3_push_images.sh
    1. Authenticate to DockerHub
    1. Push the zipster-spark container to DockerHub (the zipster-mysql container does not contain it's data yet, so pushing it won't help bring back a container ready to run easily)
1. step_4_start_docker-compose_vault-mysql-wiremock-zipster_environment.sh
    1. Initialize the /tmp/config/zipster mount point (which will contain information for containers to use Vault to self configure endpoints and secrets)
    1. Bring up a docker-compose environment for vault, mysql, wiremock, and the zipster server
    1. Wait for each container to start
1. step_5_setup_vault_in_vault-mysql-wiremock-zipster_environment.sh
    1. Unseal the vault server and save the root token
    1. Create versioned kv secrets for UUIDs and ENVIRONMENTS
1. step_6_ready_vault_in_vault-mysql-wiremock-zipster_environment.sh
    1. Create UUIDs for WireMock, MySQL, and Zipster and store those in the Vault UUID kv
    1. Create a DOCKER_COMPOSED ENVIRONMENT for each component, storing information such as endpoint, url, user, and password for dependent containers to use for self-configuration
1. step_7_verify_in_vault-mysql-wiremock-zipster_environment.sh
    1. Write Vault access information into /tmp/config/zipster, so zipster container can query Vault at correct URL and token for the DOCKER_COMPOSED environment
    1. Use mvn to run all tests
1. step_8_destroy_vault-mysql-wiremock-zipster_environment.sh
    1. Bring down the docker-compose environment
    1. Cleanup
1.  step_9 through step_D are a repeat of step_4 through step_8, but for a DESKTOP environment, where vault, mysql, and wiremock all run in containers, but the zipster server and the zipster tests run on the desktop.
    1.  It is shown here to demomstrate how nothing has to change in the zipster code to self-configure to endpoints (mysql and vault in this case), where the addresses used will be different.

TO DO:

- All of the terraform / AWS hosting.
- I still have an issue with the choice of MySQL, as it stores it's data in a Docker Volume.  That means that I can't store the database and the data as an easy to use image.  I am forced to build it from it's "source" every time I want to use it.

See https://medium.com/@pybrarian/mysql-databases-that-dont-retain-data-293bc2ed7f02