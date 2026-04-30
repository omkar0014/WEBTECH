@echo off
setlocal enabledelayedexpansion

REM Gradle wrapper for Windows
if "%OS%"=="Windows_NT" (
    set "DIRNAME=%~dp0"
) else (
    set "DIRNAME=.\"
)

set "GRADLE_OPTS=-Dorg.gradle.appname=gradlew"

if exist "%DIRNAME%gradle\wrapper\gradle-wrapper.jar" (
    "%JAVA_HOME%\bin\java.exe" %GRADLE_OPTS% -classpath "%DIRNAME%gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %*
) else (
    echo Error: Gradle wrapper JAR not found. Please run: gradle wrapper
    exit /b 1
)
