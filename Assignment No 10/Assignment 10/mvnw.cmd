@echo off
setlocal enabledelayedexpansion
set "MAVEN_PROJECTBASEDIR=%~dp0"
if "%MAVEN_PROJECTBASEDIR:~-1%"=="\" set "MAVEN_PROJECTBASEDIR=%MAVEN_PROJECTBASEDIR:~0,-1%"
set MAVEN_WRAPPER_CMD_LINE_ARGS=%*
set JAVA_EXE=java
if defined JAVA_HOME (
  set "JAVA_EXE=%JAVA_HOME%\bin\java"
)
"%JAVA_EXE%" -Dmaven.multiModuleProjectDirectory="%MAVEN_PROJECTBASEDIR%" -classpath "%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar" org.apache.maven.wrapper.MavenWrapperMain %MAVEN_WRAPPER_CMD_LINE_ARGS%
endlocal
