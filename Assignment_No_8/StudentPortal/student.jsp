<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Details</title>
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
            <a class="nav-link" href="list.jsp">Students</a>
            <a class="nav-link" href="add.jsp">Add Student</a>
        </div>
    </div>

    <header class="hero">
        <div>
            <p class="eyebrow">Student Information</p>
            <h1>Student Details</h1>
            <p class="intro">A complete view of every record stored in the student database.</p>
        </div>
        <div class="hero-actions">
            <a class="button secondary" href="index.jsp">Home</a>
            <a class="button" href="list.jsp">View Student List</a>
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
            </tr>
            </thead>
            <tbody>
            <%
            String url = "jdbc:mysql://localhost:3306/college";
            String user = "root";
            String pass = "root";

            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(url, user, pass);
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM students");

                while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("department") %></td>
                <td><%= rs.getString("email") %></td>
            </tr>
            <%
                }
            } catch(Exception e) {
                out.println("Error: " + e);
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