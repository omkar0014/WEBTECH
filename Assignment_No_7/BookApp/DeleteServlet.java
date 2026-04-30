import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/ebookshop", "root", "Siddh@111");

            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM ebookshop WHERE book_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            response.sendRedirect("books");

        } catch (Exception e) {
            response.getWriter().println(e);
        }
    }
}