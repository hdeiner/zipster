FROM openjdk:8u222-jre-slim-buster

COPY zipster-1.0-SNAPSHOT-jar-with-dependencies.jar /

COPY vault /usr/local/bin/

EXPOSE 9002

CMD ["java", "-jar", "zipster-1.0-SNAPSHOT-jar-with-dependencies.jar"]