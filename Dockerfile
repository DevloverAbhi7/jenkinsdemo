FROM maven:latest as builder

COPY pom.xml /usr/local/pom.xml
COPY server /usr/local/server
COPY client /usr/local/client
WORKDIR /usr/local/

RUN mvn clean install
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
