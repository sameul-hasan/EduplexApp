package com.diu.eduplex.controllers;

import com.diu.eduplex.models.Admin;
import com.diu.eduplex.utils.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            adminLogin(request, response);
        } else {
            response.sendRedirect("admin-login.jsp?error=Invalid action");
        }
    }

    private void adminLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE id = ? AND password = MD5(?) AND role = 'admin'";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, userId);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Create admin session
                HttpSession session = request.getSession();
                Admin admin = new Admin(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("password")
                );
                session.setAttribute("admin", admin);
                session.setAttribute("userId", userId);
                session.setAttribute("userRole", "admin");

                response.sendRedirect("admin-dashboard.jsp");
            } else {
                response.sendRedirect("admin-login.jsp?error=Invalid credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-login.jsp?error=Database error");
        }
    }
}