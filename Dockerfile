# Use JDK for building, JRE for running (multi-stage build)
FROM eclipse-temurin:21-jdk AS builder

# Install git (gradlew wrapper will handle Gradle)
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone and build
RUN git clone https://github.com/spring-projects/spring-petclinic.git . && \
    chmod +x gradlew && \
    ./gradlew clean bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built jar from builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
