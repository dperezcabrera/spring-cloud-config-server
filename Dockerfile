FROM openjdk:8-jre-alpine 
MAINTAINER David Perez Cabrera, dperezcabrera@gmail.com

EXPOSE 8888
ADD /target/spring-cloud-config-server.jar /app/
ADD /config /app/config
VOLUME /config
WORKDIR /
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar",\
            "/app/spring-cloud-config-server.jar",\
            "--server.port=8888"]
