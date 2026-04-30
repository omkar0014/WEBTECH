@echo off
REM Build Automation Script for Employee Task Management System (Windows)
REM This script provides automated building with both Maven and Gradle

setlocal enabledelayedexpansion

REM Colors using ANSI escape codes (Windows 10+)
set "GREEN=[32m"
set "RED=[31m"
set "YELLOW=[33m"
set "BLUE=[34m"
set "NC=[0m"

:main
if "%1"=="" (
    call :build_maven
    goto :end
)

if /i "%1"=="build" (
    if /i "%2"=="gradle" (
        call :build_gradle
    ) else (
        call :build_maven
    )
    goto :end
)

if /i "%1"=="gradle" (
    call :build_gradle
    goto :end
)

if /i "%1"=="maven" (
    call :build_maven
    goto :end
)

if /i "%1"=="run" (
    call :run_application %2
    goto :end
)

if /i "%1"=="test" (
    call :run_tests %2
    goto :end
)

if /i "%1"=="clean" (
    call :clean_builds
    goto :end
)

if /i "%1"=="help" (
    call :show_help
    goto :end
)

echo Unknown command: %1
call :show_help
goto :end

:build_maven
echo.
echo ========================================
echo Building with Maven
echo ========================================
if exist mvnw.cmd (
    call mvnw.cmd clean package -DskipTests
    echo.
    echo [32mBuild completed successfully![0m
    echo Package: target\employee-task-management-0.0.1-SNAPSHOT.jar
) else (
    mvn clean package -DskipTests
    echo.
    echo [32mBuild completed successfully![0m
    echo Package: target\employee-task-management-0.0.1-SNAPSHOT.jar
)
exit /b 0

:build_gradle
echo.
echo ========================================
echo Building with Gradle
echo ========================================
if not exist gradlew.cmd (
    echo [31mGradle wrapper not found![0m
    exit /b 1
)
call gradlew.cmd clean buildApp
echo.
echo [32mGradle build completed successfully![0m
echo Package: build\libs\employee-task-management.jar
exit /b 0

:run_application
if /i "%~1"=="maven" (
    echo Starting application with Maven...
    call mvnw.cmd spring-boot:run
) else if /i "%~1"=="gradle" (
    echo Starting application with Gradle...
    call gradlew.cmd bootRun
) else if /i "%~1"=="jar" (
    echo Starting application with JAR...
    if exist "target\employee-task-management-0.0.1-SNAPSHOT.jar" (
        java -jar "target\employee-task-management-0.0.1-SNAPSHOT.jar"
    ) else (
        echo [31mJAR file not found. Build the project first.[0m
        exit /b 1
    )
) else (
    call mvnw.cmd spring-boot:run
)
exit /b 0

:run_tests
if /i "%~1"=="maven" (
    call mvnw.cmd test
) else if /i "%~1"=="gradle" (
    call gradlew.cmd test
) else (
    echo No tests configured for this project
)
exit /b 0

:clean_builds
echo.
echo ========================================
echo Cleaning Build Artifacts
echo ========================================
if exist target rmdir /s /q target
if exist build rmdir /s /q build
if exist .gradle rmdir /s /q .gradle
echo [32mBuild artifacts cleaned![0m
exit /b 0

:show_help
echo.
echo ========================================
echo Employee Task Management System
echo Build Automation
echo ========================================
echo.
echo Usage: build.bat [command] [build-tool]
echo.
echo Commands:
echo   build       - Build the project (default: Maven)
echo   gradle      - Build with Gradle
echo   maven       - Build with Maven
echo   run         - Run the application (specify: maven/gradle/jar)
echo   test        - Run tests
echo   clean       - Clean build artifacts
echo   help        - Show this help message
echo.
echo Examples:
echo   build.bat build maven      # Build with Maven
echo   build.bat build gradle     # Build with Gradle
echo   build.bat run maven        # Run with Maven
echo   build.bat run gradle       # Run with Gradle
echo   build.bat run jar          # Run JAR file
echo   build.bat clean            # Clean artifacts
echo.
exit /b 0

:end
endlocal
