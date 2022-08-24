FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean install

#
# Package stage
#
FROM openjdk:11-jre-slim

COPY --from=build /home/app/target/eureka-naming-server-1.0.jar /usr/local/lib/eureka.jar

EXPOSE 8080 8443 9990
ENTRYPOINT ["java","-jar","/usr/local/lib/eureka.jar"]
