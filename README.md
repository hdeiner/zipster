How to create and test a modern REST API in a server farm environment.

Let's say we want to design a REST API that can take a zipcode and a radius and return all the zipcodes within a certain number of miles to the given cente.

Architecturally, we will use the following framworks and tools:

- Java (for our code)
- Spark (for running a small REST server)
- MySQL (for persistence of a zipcode database)
- FlyWay (to version control the database)
- Wiremock (for designing and validating the API's contract)
- Cucumber for Java (to run our integration tests in)
    - locally in Docker containers (WireMock, Spark, MySQL)
    - in cloud (using Terraform)
- Vault will also be a vital component of this project.  We will use it for holding together environments, the endpoints in those environments,and the secrets needed for those environments.


TO DO:

- the Java code itself for Spark 
- Vault stuff

I still have an issue with the choice of MySQL, as it stores it's data in a Docker Volume.  That means that I can't store the database and the data as an easy to use image.  I am forced to build it from it's "source" every time I want to use it.