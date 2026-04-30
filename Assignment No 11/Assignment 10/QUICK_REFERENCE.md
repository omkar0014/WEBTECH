# 🚀 Quick Reference - Build Commands

## Windows

### Using build.bat
```bash
# Build
.\build.bat build maven              # Build with Maven
.\build.bat build gradle             # Build with Gradle

# Run
.\build.bat run maven                # Run with Maven
.\build.bat run gradle               # Run with Gradle  
.\build.bat run jar                  # Run JAR file

# Test
.\build.bat test maven               # Run tests

# Clean
.\build.bat clean                    # Remove build artifacts

# Help
.\build.bat help                     # Show all commands
```

### Using Makefile (if make installed)
```bash
make build-maven                     # Build with Maven
make build-gradle                    # Build with Gradle
make run-maven                       # Run with Maven
make run-gradle                      # Run with Gradle
make run-jar                         # Run JAR file
make test                            # Run tests
make clean                           # Clean artifacts
make docker-build                    # Build Docker image
make docker-run                      # Run Docker container
make info                            # Show project info
```

### Direct Maven
```bash
.\mvnw.cmd clean package             # Build package
.\mvnw.cmd spring-boot:run           # Run application
.\mvnw.cmd test                      # Run tests
.\mvnw.cmd clean package -DskipTests # Build without tests
```

### Direct Gradle
```bash
.\gradlew.cmd clean build            # Build package
.\gradlew.cmd bootRun                # Run application
.\gradlew.cmd test                   # Run tests
.\gradlew.cmd clean build -x test    # Build without tests
```

---

## Linux / Mac

### Using build.sh
```bash
chmod +x build.sh                    # Make executable (first time only)

# Build
./build.sh build maven               # Build with Maven
./build.sh build gradle              # Build with Gradle

# Run
./build.sh run maven                 # Run with Maven
./build.sh run gradle                # Run with Gradle
./build.sh run jar                   # Run JAR file

# Test
./build.sh test maven                # Run tests

# Clean
./build.sh clean                     # Remove build artifacts

# Help
./build.sh help                      # Show all commands
```

### Using Makefile
```bash
make build-maven                     # Build with Maven
make build-gradle                    # Build with Gradle
make run-maven                       # Run with Maven
make run-gradle                      # Run with Gradle
make run-jar                         # Run JAR file
make test                            # Run tests
make clean                           # Clean artifacts
make docker-build                    # Build Docker image
make docker-run                      # Run Docker container
make info                            # Show project info
```

### Direct Maven
```bash
./mvnw clean package                 # Build package
./mvnw spring-boot:run               # Run application
./mvnw test                          # Run tests
./mvnw clean package -DskipTests     # Build without tests
```

### Direct Gradle
```bash
chmod +x gradlew                     # Make executable (first time only)
./gradlew clean build                # Build package
./gradlew bootRun                    # Run application
./gradlew test                       # Run tests
./gradlew clean build -x test        # Build without tests
```

---

## Docker

```bash
# Build Docker image
docker build -t employee-task-management:latest .

# Run Docker container
docker run -p 8080:8080 employee-task-management:latest

# Stop Docker container
docker stop $(docker ps -q --filter "ancestor=employee-task-management")

# Using Docker Compose
docker-compose up -d                 # Start services
docker-compose down                  # Stop services
docker-compose logs -f               # View logs
```

---

## Most Common Tasks

### Build and Run (Maven)
```bash
Windows: .\build.bat build maven && .\build.bat run maven
Linux:   ./build.sh build maven && ./build.sh run maven
Make:    make build-maven && make run-maven
```

### Build and Run (Gradle)
```bash
Windows: .\build.bat build gradle && .\build.bat run gradle
Linux:   ./build.sh build gradle && ./build.sh run gradle
Make:    make build-gradle && make run-gradle
```

### Quick Build (Skip Tests)
```bash
Windows: .\mvnw.cmd clean package -DskipTests
Linux:   ./mvnw clean package -DskipTests
```

### Run Existing JAR
```bash
java -jar target/employee-task-management-0.0.1-SNAPSHOT.jar
```

### Clean Everything
```bash
Windows: .\build.bat clean
Linux:   ./build.sh clean
Make:    make clean
```

---

## Application Access

Once running:
- **Main App:** http://localhost:8080
- **Employees:** http://localhost:8080/employees
- **Tasks:** http://localhost:8080/tasks
- **H2 Console:** http://localhost:8080/h2-console
  - JDBC URL: `jdbc:h2:mem:taskdb`
  - User: `sa`
  - Password: (leave blank)

---

## Build Outputs

### Maven
- JAR: `target/employee-task-management-0.0.1-SNAPSHOT.jar`
- Classes: `target/classes/`
- Tests: `target/test-classes/`

### Gradle
- JAR: `build/libs/employee-task-management.jar`
- Classes: `build/classes/`
- Tests: `build/test-results/`

---

## Environment Variables

```bash
# Set Java options
export JAVA_OPTS="-Xmx512m -Xms256m"

# For Gradle
export GRADLE_OPTS="-Xmx2048m"

# For Maven
export MAVEN_OPTS="-Xmx2048m"
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Port 8080 in use | Change port: `--server.port=8081` |
| Maven not found | Use: `./mvnw` (Maven wrapper) |
| Gradle wrapper not found | Run: `gradle wrapper` |
| Out of memory | Set `JAVA_OPTS` environment variable |
| Build cache issues | Run: `clean` before `build` |
| Docker permission denied | Use: `sudo docker` (Linux) |

---

## Performance Tips

### Faster Builds
```bash
# Skip tests
Maven: -DskipTests
Gradle: -x test

# Parallel compilation
Maven: -T 1C
Gradle: --parallel

# Daemon mode (Gradle)
./gradlew --daemon build
```

### Offline Mode
```bash
Maven: -o (requires cached dependencies)
Gradle: --offline (requires cached dependencies)
```

---

**Pro Tips:**
- 💡 Use `make help` to see all available targets
- 💡 Script files handle the complexity for you
- 💡 Docker is best for consistent deployments
- 💡 Always run `clean` before building if you have issues

---

**Last Updated:** April 20, 2026  
**Version:** 1.0
