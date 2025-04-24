package com.diu.eduplex.controllers;

import com.diu.eduplex.utils.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equalsIgnoreCase(action)) {
            registerUser(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            loginUser(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check if the user ID already exists
            String checkQuery = "SELECT id FROM users WHERE id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, userId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // User ID already exists
                response.sendRedirect("register.jsp?error=User ID already exists");
            } else {
                // Insert new user
                String insertQuery = "INSERT INTO users (id, name, password, phone, email, address, role) VALUES (?, ?, MD5(?), ?, ?, ?, 'user')";
                PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                insertStmt.setString(1, userId);
                insertStmt.setString(2, name);
                insertStmt.setString(3, password);
                insertStmt.setString(4, phone);
                insertStmt.setString(5, email);
                insertStmt.setString(6, address);
                insertStmt.executeUpdate();

                // Redirect to login page
                response.sendRedirect("login.jsp?success=Registration successful! Please log in.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=An error occurred. Please try again.");
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM users WHERE id = ? AND password = MD5(?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, userId);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Valid login
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userName", rs.getString("name"));
                session.setAttribute("userRole", rs.getString("role"));

                // Redirect based on role
                if ("admin".equals(rs.getString("role"))) {
                    response.sendRedirect("admin-dashboard.jsp");
                } else {
                    response.sendRedirect("movies");
                }
            } else {
                // Invalid login
                response.sendRedirect("login.jsp?error=Invalid username or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database error: " + e.getMessage());
        }
    }
}