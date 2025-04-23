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
            String userId = request.getParameter("userId");
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            try (Connection conn = DatabaseConnection.getConnection()) {
                // Check if the user ID already exists
                String checkQuery = "SELECT id FROM Users WHERE id = ?";
                PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                checkStmt.setString(1, userId);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // User ID already exists
                    response.sendRedirect("register.jsp?error=User ID already exists");
                } else {
                    // Insert new user
                    String insertQuery = "INSERT INTO Users (id, name, password, phone, address, role) VALUES (?, ?, MD5(?), ?, ?, 'user')";
                    PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                    insertStmt.setString(1, userId);
                    insertStmt.setString(2, name);
                    insertStmt.setString(3, password);
                    insertStmt.setString(4, phone);
                    insertStmt.setString(5, address);
                    insertStmt.executeUpdate();

                    // Redirect to login page
                    response.sendRedirect("login.jsp?success=Registration successful! Please log in.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("register.jsp?error=An error occurred. Please try again.");
            }
        }
    }
}