<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.diu.eduplex.models.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Movies</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">
    <div class="container mx-auto py-6">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-10">Available Movies</h1>

        <%-- Display user info if logged in --%>
        <% if(session.getAttribute("userId") != null) { %>
            <div class="mb-6 text-right px-4">
                <p>Welcome, <%= session.getAttribute("userName") %></p>
                <a href="logout.jsp" class="text-blue-600 hover:underline">Logout</a>
            </div>
        <% } %>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 px-4">
            <%
                List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                if (movies != null && !movies.isEmpty()) {
                    for (Movie movie : movies) {
            %>
            <div class="bg-white shadow-lg rounded-lg p-4">
                <h2 class="text-lg font-bold text-gray-800"><%= movie.getMovieName() %></h2>
                <p class="text-sm text-gray-600">Date: <%= movie.getShowDate() %></p>
                <p class="text-sm text-gray-600">Time: <%= movie.getShowTime() %></p>
                <p class="text-sm text-gray-600">Venue: <%= movie.getVenue() %></p>
                <p class="text-sm text-gray-600">Available Tickets: <%= movie.getNoOfTicketsAvailable() %></p>
                <p class="text-sm text-gray-600">Show Number: <%= movie.getShowNo() %></p>

                <% if(session.getAttribute("userId") != null) { %>
                    <div class="mt-4">
                        <a href="bookTicket.jsp?movieId=<%= movie.getId() %>"
                           class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition">
                            Book Now
                        </a>
                    </div>
                <% } else { %>
                    <div class="mt-4">
                        <a href="login.jsp?redirect=movies"
                           class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition">
                            Login to Book
                        </a>
                    </div>
                <% } %>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-span-3 text-center p-4">
                <p class="text-gray-600">No movies available at this time.</p>
            </div>
            <%
                }
            %>
        </div>
        <div class="text-center mt-8">
            <a href="index.jsp" class="bg-blue-600 text-white px-6 py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                Back to Home
            </a>
        </div>
    </div>
</body>
</html>