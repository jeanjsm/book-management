FROM openjdk:17-jdk-slim-buster
WORKDIR /app

COPY app/build/libs/*.jar build/

WORKDIR /app/build
ENTRYPOINT java -jar app.jar