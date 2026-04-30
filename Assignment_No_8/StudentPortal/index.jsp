<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Portal</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="page-shell">
    <div class="topbar">
        <div class="brand">
            <span>StudentPortal</span>
        </div>
        <div class="nav-links">
            <a class="nav-link active" href="index.jsp">Home</a>
            <a class="nav-link" href="list.jsp">Students</a>
            <a class="nav-link" href="add.jsp">Add Student</a>
        </div>
    </div>

    <header class="hero">
        <div>
            <p class="eyebrow">Student Portal</p>
            <h1>Welcome to the Student Information Portal</h1>
            <p class="intro">Explore, add, and update student records in a fresh, modern dashboard.</p>
        </div>
        <div class="hero-actions">
            <a class="button" href="list.jsp">View All Students</a>
            <a class="button secondary" href="add.jsp">Add New Student</a>
        </div>
    </header>

    <section class="content-card">
        <h2>Ready to manage students?</h2>
        <p class="intro">Use the navigation above to view the student list, add a new record, or edit existing student details.</p>
    </section>
</div>
</body>
</html>