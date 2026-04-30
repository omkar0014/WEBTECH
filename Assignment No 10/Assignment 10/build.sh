#!/bin/bash
# Build Automation Script for Employee Task Management System
# This script provides automated building with both Maven and Gradle

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to build with Maven
build_maven() {
    print_header "Building with Maven"
    
    if command -v mvn &> /dev/null; then
        echo "Maven found: $(mvn -version | head -1)"
        ./mvnw clean package -DskipTests
        print_success "Maven build completed successfully!"
        echo "📦 JAR: target/employee-task-management-0.0.1-SNAPSHOT.jar"
    else
        echo "Using Maven Wrapper..."
        ./mvnw clean package -DskipTests
        print_success "Maven build completed successfully!"
        echo "📦 JAR: target/employee-task-management-0.0.1-SNAPSHOT.jar"
    fi
}

# Function to build with Gradle
build_gradle() {
    print_header "Building with Gradle"
    
    if [ ! -f "gradlew" ]; then
        print_error "Gradle wrapper not found. Run: gradle wrapper"
        return 1
    fi
    
    chmod +x gradlew
    ./gradlew clean buildApp
    print_success "Gradle build completed successfully!"
    echo "📦 JAR: build/libs/employee-task-management.jar"
}

# Function to run tests
run_tests() {
    print_header "Running Tests"
    
    case "$1" in
        maven)
            ./mvnw test
            ;;
        gradle)
            ./gradlew test
            ;;
        *)
            print_warning "No tests found for this project"
            ;;
    esac
}

# Function to clean build artifacts
clean_builds() {
    print_header "Cleaning Build Artifacts"
    
    rm -rf target/ build/ .gradle/
    print_success "Build artifacts cleaned!"
}

# Function to run the application
run_application() {
    print_header "Starting Application"
    
    case "$1" in
        maven)
            echo "Starting with Maven..."
            ./mvnw spring-boot:run
            ;;
        gradle)
            echo "Starting with Gradle..."
            chmod +x gradlew
            ./gradlew bootRun
            ;;
        jar)
            echo "Starting with JAR file..."
            if [ -f "target/employee-task-management-0.0.1-SNAPSHOT.jar" ]; then
                java -jar target/employee-task-management-0.0.1-SNAPSHOT.jar
            else
                print_error "JAR file not found. Build the project first."
                return 1
            fi
            ;;
    esac
}

# Function to show help
show_help() {
    print_header "Employee Task Management System - Build Automation"
    
    echo "Usage: ./build.sh [command] [build-tool]"
    echo ""
    echo "Commands:"
    echo "  build       - Build the project (default: Maven)"
    echo "  gradle      - Build with Gradle"
    echo "  maven       - Build with Maven"
    echo "  run         - Run the application (specify: maven|gradle|jar)"
    echo "  test        - Run tests"
    echo "  clean       - Clean build artifacts"
    echo "  help        - Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./build.sh build maven      # Build with Maven"
    echo "  ./build.sh build gradle     # Build with Gradle"
    echo "  ./build.sh run maven        # Run with Maven"
    echo "  ./build.sh run gradle       # Run with Gradle"
    echo "  ./build.sh run jar          # Run JAR file"
    echo "  ./build.sh test maven       # Run tests with Maven"
    echo "  ./build.sh clean            # Clean artifacts"
    echo ""
}

# Main script logic
main() {
    if [ $# -eq 0 ]; then
        build_maven
        return
    fi
    
    case "$1" in
        build)
            if [ "$2" == "gradle" ]; then
                build_gradle
            else
                build_maven
            fi
            ;;
        gradle)
            build_gradle
            ;;
        maven)
            build_maven
            ;;
        run)
            run_application "$2"
            ;;
        test)
            run_tests "$2"
            ;;
        clean)
            clean_builds
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
