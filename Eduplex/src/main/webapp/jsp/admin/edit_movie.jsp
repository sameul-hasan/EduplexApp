<%@ page import="dao.MovieDAO,model.Movie" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    MovieDAO movieDAO = new MovieDAO();
    Movie movie = movieDAO.getMovieById(id);
%>
<%@ include file="../common/navbar.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Movie - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-b from-blue-600 to-green-400 min-h-screen flex items-center justify-center">
    <form action="../../movie" method="post" class="bg-white p-8 rounded shadow-md w-96">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="id" value="<%= movie.getId() %>">
        <img src="../../assets/logo.png" class="w-16 mx-auto mb-4">
        <h2 class="text-2xl font-bold text-center mb-6">Edit Movie</h2>
        <input name="title" type="text" required placeholder="Movie Title"
               value="<%= movie.getTitle() %>" class="w-full mb-3 p-2 border rounded">
        <textarea name="description" required placeholder="Description"
                  class="w-full mb-3 p-2 border rounded"><%= movie.getDescription() %></textarea>
        <input name="poster" type="text" required placeholder="Poster URL"
               value="<%= movie.getPoster() %>" class="w-full mb-3 p-2 border rounded">
        <input name="show_time" type="datetime-local"
               value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(movie.getShowTime()) %>"
               class="w-full mb-3 p-2 border rounded">
        <button class="bg-green-600 w-full py-2 rounded text-white font-bold hover:bg-blue-700 transition" type="submit">Update Movie</button>
        <% if(request.getParameter("error") != null) { %>
            <div class="mt-2 text-red-500 text-center">Failed to update movie!</div>
        <% } %>
    </form>
    <%@ include file="../common/footer.jsp" %>
</body>
</html>