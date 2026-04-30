<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<%
    String message = null;
    int sid = -1;
    boolean loaded = false;
    String name = "";
    String dept = "";
    String email = "";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        if(request.getParameter("id") == null) {
            message = "Missing student ID.";
        } else {
            sid = Integer.parseInt(request.getParameter("id"));
        }
    } catch(Exception e) {
        message = "Invalid student ID.";
    }

    if(message == null && "POST".equalsIgnoreCase(request.getMethod())) {
        name = request.getParameter("name");
        dept = request.getParameter("department");
        email = request.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/college", "root", "root");
            ps = con.prepareStatement("UPDATE students SET name=?, department=?, email=? WHERE id=?");
            ps.setString(1, name);
            ps.setString(2, dept);
            ps.setString(3, email);
            ps.setInt(4, sid);

            int updated = ps.executeUpdate();
            if(updated > 0) {
                response.sendRedirect("list.jsp");
                return;
            } else {
                message = "Student not found. Unable to update.";
            }
        } catch(Exception e) {
            message = "Update failed: " + e.getMessage();
        } finally {
            if(ps != null) try { ps.close(); } catch(Exception ignored) {}
            if(con != null) try { con.close(); } catch(Exception ignored) {}
            ps = null;
            con = null;
        }
    }

    if(message == null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/college", "root", "root");
            ps = con.prepareStatement("SELECT * FROM students WHERE id=?");
            ps.setInt(1, sid);
            rs = ps.executeQuery();

            if(rs.next()) {
                loaded = true;
                name = rs.getString("name");
                dept = rs.getString("department");
                email = rs.getString("email");
            } else {
                message = "Student not found.";
            }
        } catch(Exception e) {
            message = "Error loading student: " + e.getMessage();
        } finally {
            if(rs != null) try { rs.close(); } catch(Exception ignored) {}
            if(ps != null) try { ps.close(); } catch(Exception ignored) {}
            if(con != null) try { con.close(); } catch(Exception ignored) {}
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
            <a class="nav-link" href="add.jsp">Add Student</a>
        </div>
    </div>

    <header class="hero">
        <div>
            <p class="eyebrow">Edit Student</p>
            <h1>Update Student Details</h1>
            <p class="intro">Change an existing student record and save the updated details.</p>
        </div>
        <div class="hero-actions">
            <a class="button secondary" href="list.jsp">Back to List</a>
            <a class="button" href="index.jsp">Home</a>
        </div>
    </header>

    <section class="form-card">
        <% if(message != null) { %>
            <div class="alert"><%= message %></div>
        <% } %>

        <% if(loaded) { %>
            <form method="post" class="form-grid">
                <div class="form-field">
                    <label>Roll No</label>
                    <span class="alert"><%= sid %></span>
                </div>
                <div class="form-field">
                    <label for="student-name">Name</label>
                    <input id="student-name" type="text" name="name" value="<%= name %>" required>
                </div>
                <div class="form-field">
                    <label for="student-dept">Department</label>
                    <input id="student-dept" type="text" name="department" value="<%= dept %>" required>
                </div>
                <div class="form-field">
                    <label for="student-email">Email</label>
                    <input id="student-email" type="email" name="email" value="<%= email %>" required>
                </div>
                <div>
                    <input class="button" type="submit" value="Update Student">
                </div>
            </form>
        <% } %>
    </section>

    <div class="footer-nav">
        <span>Edit mode is active. Changes save directly to the database.</span>
    </div>
</div>
</body>
</html>