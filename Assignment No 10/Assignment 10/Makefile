# Makefile for Employee Task Management System

.PHONY: help build build-maven build-gradle run run-maven run-gradle run-jar test clean docker-build docker-run docker-stop info

# Default target
.DEFAULT_GOAL := help

# Colors
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m

# Help target
help:
	@echo "$(BLUE)================================$(NC)"
	@echo "$(BLUE)Employee Task Management System$(NC)"
	@echo "$(BLUE)Build Automation Targets$(NC)"
	@echo "$(BLUE)================================$(NC)"
	@echo ""
	@echo "$(YELLOW)Maven Targets:$(NC)"
	@echo "  make build-maven    Build with Maven"
	@echo "  make run-maven      Run with Maven"
	@echo "  make test-maven     Run tests with Maven"
	@echo ""
	@echo "$(YELLOW)Gradle Targets:$(NC)"
	@echo "  make build-gradle   Build with Gradle"
	@echo "  make run-gradle     Run with Gradle"
	@echo "  make test-gradle    Run tests with Gradle"
	@echo ""
	@echo "$(YELLOW)General Targets:$(NC)"
	@echo "  make build          Build with Maven (default)"
	@echo "  make run            Run with Maven (default)"
	@echo "  make run-jar        Run JAR file"
	@echo "  make test           Run tests (Maven)"
	@echo "  make clean          Clean build artifacts"
	@echo ""
	@echo "$(YELLOW)Docker Targets:$(NC)"
	@echo "  make docker-build   Build Docker image"
	@echo "  make docker-run     Run Docker container"
	@echo "  make docker-stop    Stop Docker container"
	@echo "  make docker-compose Run with Docker Compose"
	@echo ""
	@echo "$(YELLOW)Utility Targets:$(NC)"
	@echo "  make info           Show project info"
	@echo "  make deps           Show Maven dependencies"
	@echo "  make deps-gradle    Show Gradle dependencies"
	@echo ""

# Build targets
build: build-maven

build-maven:
	@echo "$(GREEN)Building with Maven...$(NC)"
	./mvnw clean package -DskipTests
	@echo "$(GREEN)✅ Maven build completed!$(NC)"

build-gradle:
	@echo "$(GREEN)Building with Gradle...$(NC)"
	chmod +x gradlew && ./gradlew clean buildApp
	@echo "$(GREEN)✅ Gradle build completed!$(NC)"

# Run targets
run: run-maven

run-maven:
	@echo "$(GREEN)Running with Maven...$(NC)"
	./mvnw spring-boot:run

run-gradle:
	@echo "$(GREEN)Running with Gradle...$(NC)"
	chmod +x gradlew && ./gradlew bootRun

run-jar:
	@echo "$(GREEN)Running JAR file...$(NC)"
	java -jar target/employee-task-management-0.0.1-SNAPSHOT.jar

# Test targets
test: test-maven

test-maven:
	@echo "$(GREEN)Running Maven tests...$(NC)"
	./mvnw test

test-gradle:
	@echo "$(GREEN)Running Gradle tests...$(NC)"
	chmod +x gradlew && ./gradlew test

# Clean target
clean:
	@echo "$(GREEN)Cleaning build artifacts...$(NC)"
	rm -rf target/ build/ .gradle/
	@echo "$(GREEN)✅ Clean completed!$(NC)"

# Docker targets
docker-build: build-maven
	@echo "$(GREEN)Building Docker image...$(NC)"
	docker build -t employee-task-management:latest .
	@echo "$(GREEN)✅ Docker image built!$(NC)"

docker-run: docker-build
	@echo "$(GREEN)Running Docker container...$(NC)"
	docker run -p 8080:8080 employee-task-management:latest

docker-stop:
	@echo "$(GREEN)Stopping Docker containers...$(NC)"
	docker stop $$(docker ps -q --filter "ancestor=employee-task-management:latest") 2>/dev/null || true
	@echo "$(GREEN)✅ Container stopped!$(NC)"

docker-compose: build-maven
	@echo "$(GREEN)Running Docker Compose...$(NC)"
	docker-compose up -d
	@echo "$(GREEN)✅ Services started!$(NC)"
	@echo "$(YELLOW)Application: http://localhost:8080$(NC)"

docker-compose-stop:
	@echo "$(GREEN)Stopping Docker Compose services...$(NC)"
	docker-compose down
	@echo "$(GREEN)✅ Services stopped!$(NC)"

# Info targets
info:
	@echo "$(BLUE)Project Information:$(NC)"
	@echo ""
	@echo "Project: Employee Task Management System"
	@echo "Version: 0.0.1-SNAPSHOT"
	@echo "Java Version: 17+"
	@echo ""
	@echo "$(YELLOW)Build Tools:$(NC)"
	@echo "Maven: $$(./mvnw -q -v | head -1)"
	@echo "Gradle: $$(./gradlew -v | grep "Gradle" | head -1)"
	@echo ""
	@echo "$(YELLOW)Directories:$(NC)"
	@echo "Source: src/main/java/com/college/employeetask/"
	@echo "Tests: src/test/java/"
	@echo "Resources: src/main/resources/"
	@echo "Build Output: target/ (Maven) / build/ (Gradle)"
	@echo ""

deps:
	@echo "$(BLUE)Maven Dependencies:$(NC)"
	./mvnw dependency:tree

deps-gradle:
	@echo "$(BLUE)Gradle Dependencies:$(NC)"
	chmod +x gradlew && ./gradlew dependencies

# Phony declarations
.PHONY: help build build-maven build-gradle run run-maven run-gradle run-jar
.PHONY: test test-maven test-gradle clean docker-build docker-run docker-stop
.PHONY: docker-compose docker-compose-stop info deps deps-gradle

# .SILENT: help
