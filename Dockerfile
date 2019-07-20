FROM maven:alpine AS builder

MAINTAINER David Perez Cabrera, dperezcabrera@gmail.com

COPY . /app/
RUN mvn dependency:go-offline -f /app/pom.xml
RUN mvn package -f /app/pom.xml

FROM openjdk:8-jre-alpine 
COPY --from=builder /app/target/spring-cloud-config-server.jar /app/
VOLUME /config

ENTRYPOINT  ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/spring-cloud-config-server.jar", "--server.port=8888"]
