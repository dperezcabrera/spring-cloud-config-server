FROM maven:alpine AS builder
MAINTAINER David Perez Cabrera, dperezcabrera@gmail.com

COPY . /app/
WORKDIR /app/
RUN mvn package

FROM openjdk:8-jre-alpine 
EXPOSE 8888
COPY --from=builder /app/target/spring-cloud-config-server.jar /app/
ADD /config /app/config
VOLUME /config
WORKDIR /
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar",\
            "/app/spring-cloud-config-server.jar",\
            "--server.port=8888"]
