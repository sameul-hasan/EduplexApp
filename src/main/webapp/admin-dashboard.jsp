<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.diu.eduplex.models.*, java.sql.*, com.diu.eduplex.utils.DatabaseConnection" %>
<%
    // Check if admin is logged in
    if(session.getAttribute("userRole") == null || !session.getAttribute("userRole").equals("admin")) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    // Fetch movies for display
    List<Movie> movies = new ArrayList<>();
    try (Connection conn = DatabaseConnection.getConnection()) {
        String query = "SELECT * FROM movies ORDER BY showDate, showTime";
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
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto py-6 px-4">
        <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">Admin Dashboard</h1>

        <!-- Success/Error messages -->
        <% if(request.getParameter("success") != null) { %>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                <%= request.getParameter("success") %>
            </div>
        <% } %>

        <% if(request.getParameter("error") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <%= request.getParameter("error") %>
            </div>
        <% } %>

        <!-- Add Movie Form -->
        <div class="bg-white shadow-lg rounded-lg p-6 mb-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Add New Movie</h2>

            <form action="movies" method="post" class="space-y-4">
                <input type="hidden" name="action" value="addMovie">

                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                        <label for="movieName" class="block text-sm font-medium text-gray-700">Movie Name</label>
                        <input type="text" id="movieName" name="movieName" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>

                    <div>
                        <label for="showDate" class="block text-sm font-medium text-gray-700">Show Date (YYYY-MM-DD)</label>
                        <input type="date" id="showDate" name="showDate" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>

                    <div>
                        <label for="showTime" class="block text-sm font-medium text-gray-700">Show Time (HH:MM:SS)</label>
                        <input type="time" id="showTime" name="showTime" step="1" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>

                    <div>
                        <label for="venue" class="block text-sm font-medium text-gray-700">Venue</label>
                        <input type="text" id="venue" name="venue" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>

                    <div>
                        <label for="noOfTicketsAvailable" class="block text-sm font-medium text-gray-700">Number of Tickets Available</label>
                        <input type="number" id="noOfTicketsAvailable" name="noOfTicketsAvailable" min="1" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>

                    <div>
                        <label for="showNo" class="block text-sm font-medium text-gray-700">Show Number</label>
                        <input type="number" id="showNo" name="showNo" min="1" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <button type="submit"
                        class="w-full bg-blue-600 text-white py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                    Add Movie
                </button>
            </form>
        </div>

        <!-- Movie List with Delete Option -->
        <div class="bg-white shadow-lg rounded-lg p-6 mb-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Manage Movies</h2>

            <% if(movies.isEmpty()) { %>
                <p class="text-gray-600">No movies available.</p>
            <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Movie Name</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Time</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Venue</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tickets</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Show #</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <% for(Movie movie : movies) { %>
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= movie.getMovieName() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= movie.getShowDate() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= movie.getShowTime() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= movie.getVenue() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= movie.getNoOfTicketsAvailable() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= movie.getShowNo() %></td>
                                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                        <form action="movies" method="post" onsubmit="return confirm('Are you sure you want to delete this movie?');">
                                            <input type="hidden" name="action" value="deleteMovie">
                                            <input type="hidden" name="movieId" value="<%= movie.getId() %>">
                                            <button type="submit" class="text-red-600 hover:text-red-900">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>

        <div class="text-center mt-8">
            <a href="logout.jsp" class="bg-red-600 text-white px-6 py-2 rounded-md shadow-md hover:bg-red-700 transition">
                Logout
            </a>
        </div>
    </div>
</body>
</html>