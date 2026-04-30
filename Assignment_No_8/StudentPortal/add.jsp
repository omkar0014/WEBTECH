<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Student</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<%
    String addError = null;
    Connection con = null;
    PreparedStatement ps = null;

    if("POST".equalsIgnoreCase(request.getMethod())) {
        int id = -1;
        String name = request.getParameter("name");
        String dept = request.getParameter("department");
        String email = request.getParameter("email");

        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch(Exception e) {
            addError = "Roll No must be a valid number.";
        }

        if(addError == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/college", "root", "root");
                ps = con.prepareStatement("INSERT INTO students VALUES(?,?,?,?)");
                ps.setInt(1, id);
                ps.setString(2, name);
                ps.setString(3, dept);
                ps.setString(4, email);
                ps.executeUpdate();
                response.sendRedirect("list.jsp");
                return;
            } catch(Exception e) {
                addError = "Failed to add student: " + e.getMessage();
            } finally {
                if(ps != null) try { ps.close(); } catch(Exception ignored) {}
                if(con != null) try { con.close(); } catch(Exception ignored) {}
            }
        }
    }
%>
<div class="page-shell">
    <div class="topbar">
        <div class="brand">
            <span>StudentPortal</span>
        </div>
        <div class="nav-links">
            <a class="nav-link" href="index.jsp">Home</a>
            <a class="nav-link" href="list.jsp">Students</a>
            <a class="nav-link active" href="add.jsp">Add Student</a>
        </div>
    </div>

    <header class="hero">
        <div>
            <p class="eyebrow">Add Student</p>
            <h1>Create a New Student Record</h1>
            <p class="intro">Fill out the form below to add a new student to the portal.</p>
        </div>
        <div class="hero-actions">
            <a class="button secondary" href="list.jsp">View All Students</a>
            <a class="button" href="index.jsp">Home</a>
        </div>
    </header>

    <section class="form-card">
        <% if(addError != null) { %>
            <div class="alert"><%= addError %></div>
        <% } %>
        <form method="post" class="form-grid">
            <div class="form-field">
                <label for="student-id">Roll No</label>
                <input id="student-id" type="text" name="id" placeholder="Enter roll number" required>
            </div>
            <div class="form-field">
                <label for="student-name">Name</label>
                <input id="student-name" type="text" name="name" placeholder="Enter student name" required>
            </div>
            <div class="form-field">
                <label for="student-dept">Department</label>
                <input id="student-dept" type="text" name="department" placeholder="Enter department" required>
            </div>
            <div class="form-field">
                <label for="student-email">Email</label>
                <input id="student-email" type="email" name="email" placeholder="Enter email address" required>
            </div>
            <div>
                <input class="button" type="submit" value="Add Student">
            </div>
        </form>
    </section>

    <div class="footer-nav">
        <span>Student Portal · Smooth form experience with live styling.</span>
    </div>
</div>
</body>
</html>