<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="page-shell">
    <div class="topbar">
        <div class="brand">
            <span>StudentPortal</span>
        </div>
        <div class="nav-links">
            <a class="nav-link" href="index.jsp">Home</a>
            <a class="nav-link active" href="list.jsp">Students</a>
            <a class="nav-link" href="add.jsp">Add Student</a>
        </div>
    </div>

    <header class="hero">
        <div>
            <p class="eyebrow">Student Records</p>
            <h1>All Students</h1>
            <p class="intro">Review student details, update records, or remove entries with confidence.</p>
        </div>
        <div class="hero-actions">
            <a class="button secondary" href="index.jsp">Home</a>
            <a class="button" href="add.jsp">➕ Add New Student</a>
        </div>
    </header>

    <section class="table-wrapper">
        <table class="table">
            <thead>
            <tr>
                <th>Roll No</th>
                <th>Name</th>
                <th>Department</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/college", "root", "root");
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM students");

                while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("department") %></td>
                <td><%= rs.getString("email") %></td>
                <td class="inline-actions">
                    <a class="action-link secondary" href="edit.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                    <a class="action-link danger" href="delete.jsp?id=<%= rs.getInt("id") %>" onclick="return confirm('Delete this student?');">Delete</a>
                </td>
            </tr>
            <%
                }
            } catch(Exception e) {
                out.print(e);
            } finally {
                if(rs != null) try { rs.close(); } catch(Exception ignored) {}
                if(st != null) try { st.close(); } catch(Exception ignored) {}
                if(con != null) try { con.close(); } catch(Exception ignored) {}
            }
            %>
            </tbody>
        </table>
    </section>
</div>
</body>
</html>