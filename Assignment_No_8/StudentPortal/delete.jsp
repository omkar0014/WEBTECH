<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Student</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<%
    String message = null;
    int sid = -1;
    Connection con = null;
    PreparedStatement ps = null;

    try {
        if(request.getParameter("id") == null) {
            message = "Missing student ID.";
        } else {
            sid = Integer.parseInt(request.getParameter("id"));
        }

        if(message == null) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/college", "root", "root");
            ps = con.prepareStatement("DELETE FROM students WHERE id=?");
            ps.setInt(1, sid);
            int deleted = ps.executeUpdate();
            if(deleted > 0) {
                response.sendRedirect("list.jsp");
                return;
            }
            message = "Student not found or already deleted.";
        }
    } catch(Exception e) {
        message = "Delete failed: " + e.getMessage();
    } finally {
        if(ps != null) try { ps.close(); } catch(Exception ignored) {}
        if(con != null) try { con.close(); } catch(Exception ignored) {}
    }
%>
<div class="page-shell">
    <div class="topbar">
        <div class="brand"><span>StudentPortal</span></div>
        <div class="nav-links">
            <a class="nav-link" href="index.jsp">Home</a>
            <a class="nav-link" href="list.jsp">Students</a>
            <a class="nav-link" href="add.jsp">Add Student</a>
        </div>
    </div>

    <header class="hero">
        <div>
            <p class="eyebrow">Delete Student</p>
            <h1>Unable to remove student</h1>
            <p class="intro">The student could not be deleted. Please try again or return to the list.</p>
        </div>
        <div class="hero-actions">
            <a class="button" href="list.jsp">Back to List</a>
            <a class="button secondary" href="index.jsp">Home</a>
        </div>
    </header>

    <section class="content-card">
        <div class="alert"><%= message %></div>
    </section>
</div>
</body>
</html>