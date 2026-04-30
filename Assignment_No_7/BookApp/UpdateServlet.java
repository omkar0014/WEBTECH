import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class UpdateServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        PrintWriter out = response.getWriter();

        out.println("<html><body style='font-family:Arial;'>");
        out.println("<h3>Edit Book</h3>");
        out.println("<form method='post' action='update'>");
        out.println("<input type='hidden' name='id' value='" + id + "'>");
        out.println("Title: <input type='text' name='title'><br><br>");
        out.println("Author: <input type='text' name='author'><br><br>");
        out.println("Price: <input type='text' name='price'><br><br>");
        out.println("Quantity: <input type='text' name='qty'><br><br>");
        out.println("<input type='submit' value='Update'>");
        out.println("</form></body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ebookshop", "root", "Siddh@111");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE ebookshop SET book_title=?, book_author=?, book_price=?, quantity=? WHERE book_id=?");

            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("author"));
            ps.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps.setInt(4, Integer.parseInt(request.getParameter("qty")));
            ps.setInt(5, Integer.parseInt(request.getParameter("id")));

            ps.executeUpdate();

            response.sendRedirect("books");

        } catch (Exception e) {
            response.getWriter().println(e);
        }
    }
}