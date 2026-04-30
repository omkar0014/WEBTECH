# 🏗️ Build and Automation Guide

## Employee Task Management System - Complete Build Setup

This guide covers building and automating the Employee Task Management System using **Maven**, **Gradle**, and **CI/CD automation**.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Maven Build](#maven-build)
3. [Gradle Build](#gradle-build)
4. [Build Automation Scripts](#build-automation-scripts)
5. [CI/CD with GitHub Actions](#cicd-with-github-actions)
6. [Docker Build](#docker-build)
7. [Comparison: Maven vs Gradle](#comparison-maven-vs-gradle)
8. [Troubleshooting](#troubleshooting)

---

## 📦 Prerequisites

- **Java 17+** installed
- **Git** for version control
- **Maven** (optional - included via wrapper)
- **Gradle** (optional - included via wrapper)
- **Docker** (optional - for containerization)

Check your setup:
```bash
java -version
git --version
```

---

## 🔨 Maven Build

### Quick Start

```bash
# Build the project
./mvnw clean package

# Run the application
./mvnw spring-boot:run

# Run tests
./mvnw test

# View dependencies
./mvnw dependency:tree
```

### Maven Commands Explained

| Command | Purpose |
|---------|---------|
| `./mvnw clean` | Remove `target/` directory |
| `./mvnw compile` | Compile source code only |
| `./mvnw package` | Compile and create JAR file |
| `./mvnw install` | Build and install in local repository |
| `./mvnw spring-boot:run` | Run the application directly |
| `./mvnw test` | Run unit tests |
| `./mvnw verify` | Run integration tests |

### Maven Lifecycle

```
clean → validate → compile → test → package → verify → install → deploy
```

### Build Output

```
✅ JAR File: target/employee-task-management-0.0.1-SNAPSHOT.jar
✅ Classes: target/classes/
✅ Tests: target/test-classes/
```

### pom.xml Structure

```xml
<project>
    <!-- Project metadata -->
    <groupId>com.college</groupId>
    <artifactId>employee-task-management</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    
    <!-- Spring Boot parent -->
    <parent>...</parent>
    
    <!-- Dependencies -->
    <dependencies>...</dependencies>
    
    <!-- Build plugins -->
    <build>
        <plugins>...</plugins>
    </build>
</project>
```

---

## 🚀 Gradle Build

### Quick Start

```bash
# Build the project
./gradlew clean build

# Run the application
./gradlew bootRun

# Run tests
./gradlew test

# View dependencies
./gradlew dependencies
```

### Gradle Commands Explained

| Command | Purpose |
|---------|---------|
| `./gradlew clean` | Remove `build/` directory |
| `./gradlew classes` | Compile source code |
| `./gradlew build` | Compile and create JAR |
| `./gradlew bootRun` | Run the application |
| `./gradlew test` | Run unit tests |
| `./gradlew buildApp` | Build with custom notifications |
| `./gradlew info` | Show project information |

### Gradle Lifecycle

```
clean → classes → jar → assemble → test → build
```

### Build Output

```
✅ JAR File: build/libs/employee-task-management.jar
✅ Classes: build/classes/
✅ Tests: build/test-results/
```

### build.gradle Structure

```gradle
plugins {
    id 'java'
    id 'org.springframework.boot'
    id 'io.spring.dependency-management'
}

group = 'com.college'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '17'

repositories {
    mavenCentral()
}

dependencies {
    // Add dependencies
}

tasks {
    // Define custom tasks
}
```

---

## 🤖 Build Automation Scripts

### Windows (PowerShell)

```bash
# Build with Maven
.\build.bat build maven

# Build with Gradle
.\build.bat build gradle

# Run the application
.\build.bat run maven
.\build.bat run gradle
.\build.bat run jar

# Run tests
.\build.bat test maven

# Clean artifacts
.\build.bat clean

# Show help
.\build.bat help
```

### Linux/Mac (Bash)

```bash
# Make script executable
chmod +x build.sh

# Build with Maven
./build.sh build maven

# Build with Gradle
./build.sh build gradle

# Run the application
./build.sh run maven
./build.sh run gradle
./build.sh run jar

# Run tests
./build.sh test maven

# Clean artifacts
./build.sh clean

# Show help
./build.sh help
```

### Script Features

✅ **Cross-platform** - Works on Windows, Linux, Mac  
✅ **Flexible** - Choose Maven or Gradle  
✅ **Automated** - Build, test, run in one command  
✅ **Error handling** - Proper exit codes and messages  
✅ **Colored output** - Easy to read terminal output  

---

## 🔄 CI/CD with GitHub Actions

### Automated Workflows

The project includes `.github/workflows/build.yml` which:

- **Tests on multiple Java versions** (17, 21)
- **Runs both Maven and Gradle builds**
- **Executes unit tests automatically**
- **Builds Docker image**
- **Runs quality checks**
- **Uploads artifacts**

### Workflow Triggers

Runs automatically on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`

### View Results

1. Go to GitHub repository
2. Click **Actions** tab
3. View build status and logs
4. Download artifacts

### Workflow Jobs

```yaml
Jobs:
  ├─ build-maven      (Java 17, 21)
  ├─ build-gradle     (Java 17, 21)
  ├─ docker-build
  ├─ quality-check
  └─ notify
```

---

## 🐳 Docker Build

### Dockerfile

```dockerfile
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
```

### Build & Run with Docker

```bash
# Build Maven package first
./mvnw clean package

# Build Docker image
docker build -t employee-task-management:latest .

# Run container
docker run -p 8080:8080 employee-task-management:latest

# Access application
# Open http://localhost:8080
```

---

## 📊 Comparison: Maven vs Gradle

| Feature | Maven | Gradle |
|---------|-------|--------|
| **Configuration** | XML (`pom.xml`) | Groovy/Kotlin (`build.gradle`) |
| **Build Speed** | Slower | Faster (incremental builds) |
| **Learning Curve** | Steeper | Gentler |
| **Convention** | Strong | Flexible |
| **Extensibility** | Plugins | Tasks |
| **IDE Support** | Excellent | Excellent |
| **CI/CD Ready** | ✅ Yes | ✅ Yes |

### When to Use Maven

- ✅ Large enterprise projects
- ✅ Team familiar with XML
- ✅ Need strict conventions
- ✅ Complex multi-module builds

### When to Use Gradle

- ✅ Fast build times needed
- ✅ Team prefers scripting
- ✅ Modern CI/CD pipelines
- ✅ Android development

---

## 🎯 Build Optimization

### Skip Tests During Build

```bash
# Maven
./mvnw clean package -DskipTests

# Gradle
./gradlew build -x test
```

### Parallel Builds

```bash
# Maven
./mvnw -T 1C clean package

# Gradle
./gradlew build --parallel
```

### Daemon Mode (Gradle)

```bash
# Use daemon for faster builds
./gradlew --daemon build

# Stop daemon
./gradlew --stop
```

### Offline Mode

```bash
# Maven (requires dependencies cached)
./mvnw clean package -o

# Gradle
./gradlew build --offline
```

---

## 📈 Build Artifacts

### Maven Output Structure

```
target/
├── classes/                    # Compiled classes
├── test-classes/              # Test classes
├── employee-task-management-0.0.1-SNAPSHOT.jar
├── maven-archiver/
└── surefire-reports/          # Test reports
```

### Gradle Output Structure

```
build/
├── classes/                    # Compiled classes
├── test-results/              # Test reports
├── libs/
│   └── employee-task-management.jar
├── tmp/
└── resources/
```

---

## 🔍 Dependency Management

### View Dependencies (Maven)

```bash
./mvnw dependency:tree

./mvnw dependency:analyze
```

### View Dependencies (Gradle)

```bash
./gradlew dependencies

./gradlew dependencyInsight --dependency spring-boot
```

### Update Dependencies

```bash
# Maven
./mvnw versions:display-dependency-updates

# Gradle
./gradlew dependencyUpdates
```

---

## 📝 Useful Maven Properties

```xml
<!-- In pom.xml -->
<properties>
    <java.version>17</java.version>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```

---

## 🐛 Troubleshooting

### Maven Issues

#### Issue: "mvn command not found"
```bash
# Solution: Use Maven wrapper
./mvnw clean package
```

#### Issue: Build cache problems
```bash
# Solution: Clean and rebuild
./mvnw clean package
```

#### Issue: Dependency resolution fails
```bash
# Solution: Update repositories
./mvnw clean package -U
```

### Gradle Issues

#### Issue: "Gradle wrapper not found"
```bash
# Solution: Create wrapper
gradle wrapper

# Then use
./gradlew build
```

#### Issue: Out of memory during build
```bash
# Solution: Increase JVM memory
export GRADLE_OPTS="-Xmx2048m"
./gradlew build
```

#### Issue: Gradle daemon hanging
```bash
# Solution: Stop and restart daemon
./gradlew --stop
./gradlew build --no-daemon
```

---

## 🎓 Advanced Topics

### Custom Maven Plugins

```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <executions>
        <execution>
            <goals>
                <goal>build-info</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

### Custom Gradle Tasks

```gradle
task customBuild {
    dependsOn clean, build
    doLast {
        println "✅ Custom build completed!"
    }
}
```

---

## 📞 Support & Documentation

- **Maven**: https://maven.apache.org/
- **Gradle**: https://gradle.org/
- **Spring Boot**: https://spring.io/projects/spring-boot
- **GitHub Actions**: https://docs.github.com/en/actions

---

## ✅ Quick Reference

### Build & Run (Maven)
```bash
./mvnw clean spring-boot:run
```

### Build & Run (Gradle)
```bash
./gradlew clean bootRun
```

### Build Only (Maven)
```bash
./mvnw clean package
```

### Build Only (Gradle)
```bash
./gradlew clean build
```

### Run JAR
```bash
java -jar target/employee-task-management-0.0.1-SNAPSHOT.jar
```

### Docker
```bash
./mvnw clean package && docker build -t app . && docker run -p 8080:8080 app
```

---

**Last Updated**: April 2026  
**Version**: 1.0  
**Status**: ✅ Ready for Production
