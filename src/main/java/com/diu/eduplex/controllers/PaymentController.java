package com.diu.eduplex.controllers;

import com.diu.eduplex.utils.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        float amount = Float.parseFloat(request.getParameter("amount"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO Payments (userId, amount, transactionId, paymentDate) VALUES (?, ?, ?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, userId);
            stmt.setFloat(2, amount);
            stmt.setInt(3, (int) (Math.random() * 100000)); // Random transaction ID
            stmt.executeUpdate();

            response.sendRedirect("confirmation.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("confirmation.jsp?status=failure");
        }
    }
}