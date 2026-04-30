# Multi-stage Docker build for Employee Task Management System

# Stage 1: Build
FROM eclipse-temurin:21-jdk-jammy AS builder

WORKDIR /workspace

# Copy Maven wrapper
COPY mvnw mvnw
COPY .mvn .mvn

# Copy pom.xml and source
COPY pom.xml pom.xml
COPY src src

# Build application
RUN chmod +x mvnw && \
    ./mvnw clean package -DskipTests -q

# Extract jar layers for better caching
RUN mkdir -p target/dependency && \
    (cd target/dependency; jar -xf ../*.jar)

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-jammy

# Add metadata
LABEL maintainer="College Engineering Department"
LABEL description="Employee Task Management System"
LABEL version="0.0.1"

WORKDIR /app

# Set environment variables
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENV SPRING_PROFILES_ACTIVE=production

# Copy application from builder
COPY --from=builder /workspace/target/*.jar app.jar

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD java -cp app.jar org.springframework.boot.loader.JarLauncher || exit 1

# Expose port
EXPOSE 8080

# Run application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
