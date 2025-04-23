package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("register".equals(action)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(pass);
            user.setIsAdmin(false);
            if (userDAO.registerUser(user)) {
                res.sendRedirect("jsp/common/login.jsp?success=1");
            } else {
                res.sendRedirect("jsp/common/register.jsp?error=1");
            }
        } else if ("login".equals(action)) {
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            User user = userDAO.getUserByEmail(email);
            if (user != null && user.getPassword().equals(pass)) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                if (user.isAdmin()) {
                    res.sendRedirect("jsp/admin/dashboard.jsp");
                } else {
                    res.sendRedirect("jsp/user/dashboard.jsp");
                }
            } else {
                res.sendRedirect("jsp/common/login.jsp?error=1");
            }
        }
    }
}