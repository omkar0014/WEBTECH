import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        out.println("<html><style>");
        out.println("body{font-family:Arial;background:#f4f4f4;}");
        out.println(".form{width:300px;margin:auto;background:white;padding:20px;border-radius:10px;box-shadow:0 0 10px gray;}");
        out.println("input{width:100%;padding:8px;margin:5px 0;}");
        out.println("button{background:green;color:white;padding:10px;border:none;width:100%;}");
        out.println("</style><body>");

        out.println("<div class='form'>");
        out.println("<h3>Add Book</h3>");
        out.println("<form method='post' action='add'>");
        out.println("<input type='text' name='title' placeholder='Title'>");
        out.println("<input type='text' name='author' placeholder='Author'>");
        out.println("<input type='text' name='price' placeholder='Price'>");
        out.println("<input type='text' name='qty' placeholder='Quantity'>");
        out.println("<button>Add</button>");
        out.println("</form></div></body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ebookshop", "root", "Siddh@111");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO ebookshop (book_title, book_author, book_price, quantity) VALUES (?, ?, ?, ?)");

            ps.setString(1, request.getParameter("title"));
            ps.setString(2, request.getParameter("author"));
            ps.setDouble(3, Double.parseDouble(request.getParameter("price")));
            ps.setInt(4, Integer.parseInt(request.getParameter("qty")));

            ps.executeUpdate();

            response.sendRedirect("books");

        } catch (Exception e) {
            response.getWriter().println(e);
        }
    }
}