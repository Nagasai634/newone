# ---------- Builder Stage ----------
FROM eclipse-temurin:25-jdk AS builder

# Install required tools
RUN apt-get update && apt-get install -y git maven

# Clone and build the Spring Petclinic project
WORKDIR /sai
RUN git clone https://github.com/spring-projects/spring-petclinic.git
WORKDIR /sai/spring-petclinic
RUN mvn clean package -DskipTests

# ---------- Runtime Stage ----------
FROM eclipse-temurin:25-jdk

WORKDIR /app2
COPY --from=builder /sai/spring-petclinic/target/*.jar /app2/sai.jar

EXPOSE 8080
CMD ["java", "-jar", "/app2/sai.jar"]
