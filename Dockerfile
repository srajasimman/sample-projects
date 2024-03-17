FROM maven:3.9.6-sapmachine-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
LABEL org.opencontainers.image.source https://github.com/srajasimman/sample-projects
ENV APP_HOME=/app \
    APP_USER=app
WORKDIR $APP_HOME
COPY --from=build $APP_HOME/target/*.jar $APP_USER.jar
RUN adduser -u 5678 --disabled-password --gecos "" $APP_USER && chown -R $APP_USER $APP_HOME
ENTRYPOINT ["java", "-jar", "app.jar"]