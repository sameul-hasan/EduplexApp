package com.diu.eduplex.controllers;

import com.diu.eduplex.utils.DatabaseConnection;
import com.diu.eduplex.utils.EmailUtility;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookingController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("bookTickets".equals(action)) {
            bookTickets(request, response);
        } else if ("processPayment".equals(action)) {
            processPayment(request, response);
        } else {
            response.sendRedirect("movies");
        }
    }

    private void bookTickets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        String userId = request.getParameter("userId");
        int numTickets = Integer.parseInt(request.getParameter("numTickets"));

        // Calculate total amount
        double ticketPrice = 10.0; // $10 per ticket
        double totalAmount = numTickets * ticketPrice;

        // Store booking info in session for payment processing
        HttpSession session = request.getSession();
        session.setAttribute("bookingMovieId", movieId);
        session.setAttribute("bookingUserId", userId);
        session.setAttribute("bookingNumTickets", numTickets);
        session.setAttribute("bookingAmount", totalAmount);

        // Forward to payment page
        request.setAttribute("amount", totalAmount);
        request.setAttribute("numTickets", numTickets);

        // Get movie details for display
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT movieName, showDate, showTime, venue FROM movies WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, movieId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("movieName", rs.getString("movieName"));
                request.setAttribute("showDate", rs.getString("showDate"));
                request.setAttribute("showTime", rs.getString("showTime"));
                request.setAttribute("venue", rs.getString("venue"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
        dispatcher.forward(request, response);
    }

    private void processPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve booking info from session
        int movieId = (int) session.getAttribute("bookingMovieId");
        String userId = (String) session.getAttribute("bookingUserId");
        int numTickets = (int) session.getAttribute("bookingNumTickets");
        double amount = (double) session.getAttribute("bookingAmount");

        // Generate random transaction ID
        int transactionId = (int) (Math.random() * 1000000);

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            try {
                // 1. Insert payment record
                String paymentQuery = "INSERT INTO payments (userId, amount, transactionId, paymentDate) VALUES (?, ?, ?, NOW())";
                PreparedStatement paymentStmt = conn.prepareStatement(paymentQuery);
                paymentStmt.setString(1, userId);
                paymentStmt.setDouble(2, amount);
                paymentStmt.setInt(3, transactionId);
                paymentStmt.executeUpdate();

                // 2. Insert ticket record
                String ticketQuery = "INSERT INTO tickets (movieId, userId, noOfTickets, bookingDate) VALUES (?, ?, ?, NOW())";
                PreparedStatement ticketStmt = conn.prepareStatement(ticketQuery);
                ticketStmt.setInt(1, movieId);
                ticketStmt.setString(2, userId);
                ticketStmt.setInt(3, numTickets);
                ticketStmt.executeUpdate();

                // 3. Update movie tickets available
                String updateQuery = "UPDATE movies SET noOfTicketsAvailable = noOfTicketsAvailable - ? WHERE id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
                updateStmt.setInt(1, numTickets);
                updateStmt.setInt(2, movieId);
                updateStmt.executeUpdate();

                // 4. Get user email for notification
                String userQuery = "SELECT name, phone, email FROM users WHERE id = ?";
                PreparedStatement userStmt = conn.prepareStatement(userQuery);
                userStmt.setString(1, userId);
                ResultSet userRs = userStmt.executeQuery();

                String userName = "";
                String userPhone = "";
                String userEmail = "";
                if (userRs.next()) {
                    userName = userRs.getString("name");
                    userPhone = userRs.getString("phone");
                    userEmail = userRs.getString("email");
                }

                // 5. Get movie details for notification
                String movieQuery = "SELECT movieName, showDate, showTime, venue FROM movies WHERE id = ?";
                PreparedStatement movieStmt = conn.prepareStatement(movieQuery);
                movieStmt.setInt(1, movieId);
                ResultSet movieRs = movieStmt.executeQuery();

                String movieName = "";
                String showDate = "";
                String showTime = "";
                String venue = "";

                if (movieRs.next()) {
                    movieName = movieRs.getString("movieName");
                    showDate = movieRs.getString("showDate");
                    showTime = movieRs.getString("showTime");
                    venue = movieRs.getString("venue");
                }

                // Commit transaction
                conn.commit();

                // Send email notification - UPDATED: Added userEmail parameter
                sendBookingConfirmation(userName, userPhone, userEmail, movieName, showDate, showTime, venue, numTickets, amount, transactionId);

                // Set success attributes
                request.setAttribute("transactionId", transactionId);
                request.setAttribute("movieName", movieName);
                request.setAttribute("showDate", showDate);
                request.setAttribute("showTime", showTime);
                request.setAttribute("venue", venue);
                request.setAttribute("numTickets", numTickets);
                request.setAttribute("amount", amount);

                // Clear session booking data
                session.removeAttribute("bookingMovieId");
                session.removeAttribute("bookingUserId");
                session.removeAttribute("bookingNumTickets");
                session.removeAttribute("bookingAmount");

                // Forward to confirmation page
                RequestDispatcher dispatcher = request.getRequestDispatcher("confirmation.jsp?status=success");
                dispatcher.forward(request, response);

            } catch (Exception e) {
                conn.rollback(); // Rollback in case of error
                throw e;
            } finally {
                conn.setAutoCommit(true); // Reset auto-commit
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=Payment processing failed: " + e.getMessage());
        }
    }

    // UPDATED: Added userEmail parameter to method signature
    private void sendBookingConfirmation(String userName, String userPhone, String userEmail, String movieName,
                                         String showDate, String showTime, String venue,
                                         int numTickets, double amount, int transactionId) {
        try {
            // Create email subject and body
            String subject = "Ticket Booking Confirmation - " + movieName;

            StringBuilder body = new StringBuilder();
            body.append("Dear ").append(userName).append(",\n\n");
            body.append("Thank you for booking tickets at Eduplex!\n\n");
            body.append("Booking Details:\n");
            body.append("Movie: ").append(movieName).append("\n");
            body.append("Date: ").append(showDate).append("\n");
            body.append("Time: ").append(showTime).append("\n");
            body.append("Venue: ").append(venue).append("\n");
            body.append("Number of Tickets: ").append(numTickets).append("\n");
            body.append("Total Amount: $").append(amount).append("\n");
            body.append("Transaction ID: ").append(transactionId).append("\n\n");
            body.append("Please show this email or provide your Transaction ID at the theater.\n\n");
            body.append("Enjoy the movie!\n\n");
            body.append("Regards,\nEduplex Team");

            // Send email using EmailUtility
            EmailUtility.sendEmail(userEmail, subject, body.toString());

            // Instead of actually sending an email (since this is a demo),
            // we'll just print the notification to the console
            System.out.println("========== BOOKING CONFIRMATION ==========");
            System.out.println("To: " + userName + " (Email: " + userEmail + ", Phone: " + userPhone + ")");
            System.out.println("Subject: " + subject);
            System.out.println("Message: \n" + body.toString());
            System.out.println("=========================================");

        } catch (Exception e) {
            System.out.println("Failed to send booking confirmation: " + e.getMessage());
            e.printStackTrace();
        }
    }
}