import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class BookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head>");
        out.println("<style>");
        out.println("body{font-family:Arial;background:linear-gradient(to right,#74ebd5,#ACB6E5);}");
        out.println(".container{width:80%;margin:auto;background:white;padding:20px;border-radius:10px;box-shadow:0 0 10px gray;}");
        out.println("h2{text-align:center;}");
        out.println("table{width:100%;border-collapse:collapse;margin-top:20px;}");
        out.println("th,td{padding:10px;text-align:center;border:1px solid #ddd;}");
        out.println("th{background:#333;color:white;}");
        out.println(".btn{padding:6px 12px;border:none;border-radius:5px;color:white;text-decoration:none;}");
        out.println(".add{background:green;}");
        out.println(".edit{background:blue;}");
        out.println(".delete{background:red;}");
        out.println("</style></head><body>");

        out.println("<div class='container'>");
        out.println("<h2>📚 Book Store</h2>");

        out.println("<a class='btn add' href='add'>➕ Add Book</a>");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ebookshop", "root", "Siddh@111");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM ebookshop");

            out.println("<table>");
            out.println("<tr><th>ID</th><th>Title</th><th>Author</th><th>Price</th><th>Qty</th><th>Action</th></tr>");

            while (rs.next()) {
                int id = rs.getInt("book_id");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + rs.getString("book_title") + "</td>");
                out.println("<td>" + rs.getString("book_author") + "</td>");
                out.println("<td>" + rs.getDouble("book_price") + "</td>");
                out.println("<td>" + rs.getInt("quantity") + "</td>");

                out.println("<td>");
                out.println("<a class='btn edit' href='update?id=" + id + "'>Edit</a> ");
                out.println("<a class='btn delete' href='delete?id=" + id + "' onclick='return confirm(\"Delete?\")'>Delete</a>");
                out.println("</td>");

                out.println("</tr>");
            }

            out.println("</table>");
            con.close();

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }

        out.println("</div></body></html>");
    }
}