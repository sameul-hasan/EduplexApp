<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.diu.eduplex.models.*, com.diu.eduplex.utils.*, java.sql.*" %>
<%
    // Check if user is logged in
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp?error=Please login to book tickets");
        return;
    }

    int movieId = Integer.parseInt(request.getParameter("movieId"));
    Movie movie = null;

    try (Connection conn = DatabaseConnection.getConnection()) {
        String query = "SELECT * FROM movies WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, movieId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            movie = new Movie(
                rs.getInt("id"),
                rs.getString("movieName"),
                rs.getString("showDate"),
                rs.getString("showTime"),
                rs.getString("venue"),
                rs.getInt("noOfTicketsAvailable"),
                rs.getInt("showNo")
            );
        } else {
            response.sendRedirect("movies?error=Movie not found");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("movies?error=Database error");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book Ticket - <%= movie.getMovieName() %></title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto py-6 px-4">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-10">Book Tickets</h1>

        <!-- Movie details -->
        <div class="bg-white shadow-lg rounded-lg p-6 mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-4"><%= movie.getMovieName() %></h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <p class="text-gray-700"><strong>Date:</strong> <%= movie.getShowDate() %></p>
                    <p class="text-gray-700"><strong>Time:</strong> <%= movie.getShowTime() %></p>
                    <p class="text-gray-700"><strong>Venue:</strong> <%= movie.getVenue() %></p>
                </div>
                <div>
                    <p class="text-gray-700"><strong>Available Tickets:</strong> <%= movie.getNoOfTicketsAvailable() %></p>
                    <p class="text-gray-700"><strong>Show Number:</strong> <%= movie.getShowNo() %></p>
                </div>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h3 class="text-xl font-bold text-gray-800 mb-4">Select Number of Tickets</h3>

            <form action="booking" method="post" class="space-y-4" id="bookingForm">
                <input type="hidden" name="action" value="bookTickets">
                <input type="hidden" name="movieId" value="<%= movie.getId() %>">
                <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>">

                <div>
                    <label for="numTickets" class="block text-sm font-medium text-gray-700">Number of Tickets</label>
                    <input type="number" id="numTickets" name="numTickets" min="1" max="<%= movie.getNoOfTicketsAvailable() %>" required
                           class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700">Ticket Price: $10 per ticket</label>
                    <p class="text-lg font-bold text-blue-600">Total: $<span id="totalPrice">0</span></p>
                </div>

                <div class="pt-4">
                    <button type="submit"
                            class="w-full bg-blue-600 text-white py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                        Proceed to Payment
                    </button>
                </div>
            </form>
        </div>

        <div class="text-center mt-8">
            <a href="movies" class="bg-gray-500 text-white px-6 py-2 rounded-md shadow-md hover:bg-gray-600 transition">
                Back to Movies
            </a>
        </div>
    </div>

    <script>
        document.getElementById('numTickets').addEventListener('input', function() {
            const numTickets = this.value || 0;
            const totalPrice = numTickets * 10; // $10 per ticket
            document.getElementById('totalPrice').textContent = totalPrice;
        });

        document.getElementById('bookingForm').addEventListener('submit', function(e) {
            const numTickets = document.getElementById('numTickets').value;
            const maxTickets = <%= movie.getNoOfTicketsAvailable() %>;

            if (numTickets > maxTickets) {
                e.preventDefault();
                alert(`Sorry, only ${maxTickets} tickets are available.`);
            }
        });
    </script>
</body>
</html>