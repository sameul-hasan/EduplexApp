<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Movies</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">
    <div class="container mx-auto py-6">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-10">Available Movies</h1>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <%
                List<com.diu.eduplex.models.Movie> movies = (List<com.diu.eduplex.models.Movie>) request.getAttribute("movies");
                if (movies != null) {
                    for (com.diu.eduplex.models.Movie movie : movies) {
            %>
            <div class="bg-white shadow-lg rounded-lg p-4">
                <h2 class="text-lg font-bold text-gray-800"><%= movie.getMovieName() %></h2>
                <p class="text-sm text-gray-600">Show: <%= movie.getMovieShow() %></p>
                <p class="text-sm text-gray-600">Venue: <%= movie.getVenue() %></p>
            </div>
            <%
                    }
                } else {
            %>
            <p class="text-gray-600">No movies available.</p>
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