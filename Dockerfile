FROM maven:3.8-openjdk-11 as build
WORKDIR .
COPY . .
RUN mvn install




FROM openjdk:11-jre-slim
COPY --from=build /target/devops-integration.jar devops-integration.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]
CMD ["java","-jar","/devops-integration.jar"]
