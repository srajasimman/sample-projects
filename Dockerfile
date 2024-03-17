FROM gradle:8-jdk17 AS build
ENV APP_HOME=/usr/app
WORKDIR $APP_HOME
COPY build.gradle settings.gradle $APP_HOME/
COPY gradle $APP_HOME/gradle
COPY --chown=gradle:gradle . /home/gradle/src
USER root
RUN chown -R gradle /home/gradle/src

RUN gradle build || return 0
COPY . .
RUN gradle clean build

FROM openjdk:17-jdk-slim
LABEL org.opencontainers.image.source https://github.com/srajasimman/sample-projects
ENV APP_HOME=/usr/app/

WORKDIR $APP_HOME
COPY --from=build $APP_HOME/build/libs/*.jar $APP_HOME/app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]