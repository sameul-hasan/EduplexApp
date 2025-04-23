<%@ page import="dao.MovieDAO,model.Movie,java.util.List,dao.UserDAO,dao.BookingDAO" %>
<%@ page session="true" %>
<%
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> movies = movieDAO.getAllMovies();
    UserDAO userDAO = new UserDAO();
    BookingDAO bookingDAO = new BookingDAO();
    int totalMovies = movies.size();
    int totalUsers = userDAO.countUsers();
    int totalBookings = bookingDAO.countBookings();
%>
<%@ include file="../common/navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin - Manage Movies</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-b from-green-400 to-blue-600 min-h-screen">
    <div class="container mx-auto py-8">
        <div class="flex items-center justify-between mb-6">
            <img src="../../assets/logo.png" class="w-16">
            <div>
              <a href="add_movie.jsp" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">Add Movie</a>
              <a href="users.jsp" class="bg-blue-700 text-white px-4 py-2 rounded hover:bg-green-600 transition ml-2">View Users</a>
              <a href="bookings.jsp" class="bg-green-700 text-white px-4 py-2 rounded hover:bg-blue-700 transition ml-2">All Bookings</a>
            </div>
        </div>
        <!-- Analytics -->
        <div class="flex space-x-6 mb-6">
            <div class="bg-white p-4 rounded shadow text-center flex-1">
                <div class="text-2xl font-bold text-green-700"><%= totalMovies %></div>
                <div>Total Movies</div>
            </div>
            <div class="bg-white p-4 rounded shadow text-center flex-1">
                <div class="text-2xl font-bold text-blue-700"><%= totalUsers %></div>
                <div>Total Users</div>
            </div>
            <div class="bg-white p-4 rounded shadow text-center flex-1">
                <div class="text-2xl font-bold text-green-700"><%= totalBookings %></div>
                <div>Total Bookings</div>
            </div>
        </div>
        <h2 class="text-3xl text-white font-bold mb-4">All Movies</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <% for(Movie m: movies) { %>
                <div class="bg-white rounded shadow p-4">
                    <img src="<%= m.getPoster() %>" class="h-48 object-cover mb-2 w-full rounded">
                    <h3 class="text-xl font-bold text-green-700 mb-2"><%= m.getTitle() %></h3>
                    <p class="mb-2"><%= m.getDescription() %></p>
                    <p class="text-blue-600 font-bold mb-2">Show Time: <%= m.getShowTime() %></p>
                    <a href="edit_movie.jsp?id=<%= m.getId() %>" class="bg-blue-500 text-white px-3 py-1 rounded mr-2">Edit</a>
                    <form action="../../movie" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= m.getId() %>">
                        <button type="submit"
                           class="bg-red-600 text-white px-3 py-1 rounded"
                           onclick="return confirm('Delete this movie?');">Delete</button>
                    </form>
                </div>
            <% } %>
        </div>
        <% if(request.getParameter("success") != null) { %>
            <div class="mt-4 text-green-700 font-bold">Movie added successfully!</div>
        <% } %>
        <% if(request.getParameter("updated") != null) { %>
            <div class="mt-4 text-green-700 font-bold">Movie updated successfully!</div>
        <% } %>
        <% if(request.getParameter("deleted") != null) { %>
            <div class="mt-4 text-green-700 font-bold">Movie deleted successfully!</div>
        <% } %>
    </div>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>