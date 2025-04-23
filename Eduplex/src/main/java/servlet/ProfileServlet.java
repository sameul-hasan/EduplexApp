package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            res.sendRedirect("jsp/common/login.jsp");
            return;
        }
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean updated = userDAO.updateProfile(user.getId(), email, password);
        if (updated) {
            user.setEmail(email);
            if (password != null && !password.trim().isEmpty()) user.setPassword(password);
            session.setAttribute("user", user);
            res.sendRedirect("jsp/user/profile.jsp?success=1");
        } else {
            res.sendRedirect("jsp/user/profile.jsp?error=1");
        }
    }
}