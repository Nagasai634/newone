FROM maven:latest AS builder
RUN apt update -y
RUN apt install git -y
WORKDIR /app
RUN git clone https://github.com/spring-projects/spring-petclinic.git 
RUN cd /app/spring-petclinic && mvn clean package -DskipTests

FROM openjdk:25-jdk
WORKDIR /app2
COPY --from=builder /app/spring-petclinic/target/*.jar  /app2/sai.jar
EXPOSE 8080
CMD [ "java","-jar","/app2/sai.jar" ]
