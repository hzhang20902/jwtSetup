FROM maven:3.8.5-openjdk-17 AS build
RUN mkdir -p jwtexample
WORKDIR jwtexample
COPY pom.xml /jwtexample
COPY src /jwtexample/src
RUN mvn -f pom.xml clean install -DskipTests=true

FROM openjdk:17-alpine3.14
COPY --from=build /jwtexample/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]