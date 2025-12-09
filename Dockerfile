FROM eclipse-temurin:25-jre

# Update package list and install Maven and wget
RUN apt update -y && \
    apt install maven -y && \
    apt install -y git && \
    apt clean

# Set the working directory
WORKDIR /app

# Clone the Spring Pet Clinic repository
RUN git clone https://github.com/spring-projects/spring-petclinic.git .

# Build the application
RUN mvn clean package -DskipTests

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "/app/target/spring-petclinic-2.6.0-SNAPSHOT.jar"]
