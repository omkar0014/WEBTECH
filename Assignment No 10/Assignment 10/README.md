# Employee Task Management System

A Spring Boot application for the Engineering Department to manage faculty assignments and task tracking.

## Features
- Manage employee/faculty records
- Create, edit, delete tasks
- Assign tasks to faculty members
- Track task due dates and status
- In-memory H2 database with starter sample data

## Requirements
- Java 17
- Maven 3.x

## Run the app
1. Open a terminal in `d:\c\Assignment 10`
2. Run:
   ```bash
   mvn spring-boot:run
   ```
3. Open `http://localhost:8080`

## H2 Console
- URL: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:taskdb`
- User: `sa`
- Password: (leave blank)

## Project structure
- `src/main/java/com/college/employeetask` contains application sources
- `src/main/resources/templates` contains Thymeleaf views
- `src/main/resources/data.sql` loads sample employees and tasks on startup
