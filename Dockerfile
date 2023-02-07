FROM gradle:jdk11 as gradleimage
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

#ARG SERVER_PORT=5000
#ENV SERVER_PORT=$SERVER_PORT

RUN gradle clean build

FROM openjdk:11-jre-slim
COPY --from=gradleimage /home/gradle/src/build/libs/orangutan-0.0.1-SNAPSHOT.jar /app/orangutan-0.0.1-SNAPSHOT.jar
EXPOSE 5000
WORKDIR /app
ENTRYPOINT ["java" , "-Xmx2048m", "-jar", "orangutan-0.0.1-SNAPSHOT.jar"]
