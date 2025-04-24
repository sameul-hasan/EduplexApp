package com.diu.eduplex.controllers;

import com.diu.eduplex.models.Movie;
import com.diu.eduplex.utils.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Movie> movies = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "SELECT * FROM movies";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Movie movie = new Movie(
                        rs.getInt("id"),
                        rs.getString("movieName"),
                        rs.getString("showDate"),
                        rs.getString("showTime"),
                        rs.getString("venue"),
                        rs.getInt("noOfTicketsAvailable"),
                        rs.getInt("showNo")
                );
                movies.add(movie);
            }
            System.out.println("Successfully fetched " + movies.size() + " movies");
        } catch (Exception e) {
            System.out.println("Error retrieving movies: " + e.getMessage());
            e.printStackTrace();
        }

        request.setAttribute("movies", movies);
        RequestDispatcher dispatcher = request.getRequestDispatcher("movies.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addMovie".equals(action)) {
            addMovie(request, response);
        } else if ("deleteMovie".equals(action)) {
            deleteMovie(request, response);
        } else {
            response.sendRedirect("movies");
        }
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieName = request.getParameter("movieName");
        String showDate = request.getParameter("showDate");
        String showTime = request.getParameter("showTime");
        String venue = request.getParameter("venue");
        int noOfTicketsAvailable = Integer.parseInt(request.getParameter("noOfTicketsAvailable"));
        int showNo = Integer.parseInt(request.getParameter("showNo"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO movies (movieName, showDate, showTime, venue, noOfTicketsAvailable, showNo) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, movieName);
            stmt.setString(2, showDate);
            stmt.setString(3, showTime);
            stmt.setString(4, venue);
            stmt.setInt(5, noOfTicketsAvailable);
            stmt.setInt(6, showNo);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Movie added successfully: " + movieName);
                response.sendRedirect("admin-dashboard.jsp?success=Movie added successfully");
            } else {
                response.sendRedirect("admin-dashboard.jsp?error=Failed to add movie");
            }
        } catch (Exception e) {
            System.out.println("Error adding movie: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?error=Database error: " + e.getMessage());
        }
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check if there are any tickets booked for this movie
            String checkQuery = "SELECT COUNT(*) FROM tickets WHERE movieId = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setInt(1, movieId);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int ticketCount = rs.getInt(1);

            if (ticketCount > 0) {
                response.sendRedirect("admin-dashboard.jsp?error=Cannot delete movie with booked tickets");
                return;
            }

            // Delete the movie
            String deleteQuery = "DELETE FROM movies WHERE id = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, movieId);

            int rowsDeleted = deleteStmt.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("admin-dashboard.jsp?success=Movie deleted successfully");
            } else {
                response.sendRedirect("admin-dashboard.jsp?error=Movie not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?error=Error deleting movie: " + e.getMessage());
        }
    }
}