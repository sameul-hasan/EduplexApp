<%@ page import="dao.MovieDAO,dao.BookingDAO,model.Movie,java.util.List" %>
<%@ include file="../common/navbar.jsp" %>
<%
    String movieIdParam = request.getParameter("movie_id");
    if (movieIdParam == null) {
%>
    <div class="container mx-auto py-12 text-center">
        <div class="text-2xl text-red-600 font-bold">No movie selected for booking.</div>
        <a href="dashboard.jsp" class="mt-4 inline-block bg-blue-600 text-white px-4 py-2 rounded">Back to Movies</a>
    </div>
<%
        return;
    }
    int movieId = Integer.parseInt(movieIdParam);
    MovieDAO movieDAO = new MovieDAO();
    BookingDAO bookingDAO = new BookingDAO();
    Movie movie = movieDAO.getMovieById(movieId);
    List<String> bookedSeats = bookingDAO.getBookedSeatsForMovie(movieId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book Ticket - <%= movie.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-b from-blue-100 to-green-200 min-h-screen">
<div class="container mx-auto py-12">
    <div class="max-w-lg mx-auto bg-white rounded shadow p-8">
        <div class="flex items-center mb-6">
            <img src="<%= movie.getPoster() %>" class="w-20 h-28 mr-4 rounded shadow">
            <div>
                <h2 class="text-2xl font-bold mb-2"><%= movie.getTitle() %></h2>
                <p class="text-gray-700 mb-1"><%= movie.getDescription() %></p>
                <p class="text-blue-600 font-bold">Show Time: <%= movie.getShowTime() %></p>
            </div>
        </div>
        <form action="../../booking" method="post">
            <input type="hidden" name="action" value="book">
            <input type="hidden" name="movie_id" value="<%= movieId %>">
            <div class="mb-4">
                <label class="font-bold mb-2 block">Select Seat:</label>
                <div id="seat-map" class="inline-block">
                    <div class="flex flex-col gap-2">
                        <%
                            for(char row = 'A'; row <= 'C'; row++) {
                        %>
                            <div class="flex gap-2 justify-center">
                                <% for(int col = 1; col <= 5; col++) {
                                    String seatValue = row + String.valueOf(col);
                                    boolean isBooked = bookedSeats.contains(seatValue);
                                %>
                                <label class="cursor-pointer relative">
                                    <input
                                        type="radio"
                                        name="seat"
                                        value="<%= seatValue %>"
                                        class="peer appearance-none"
                                        <%= isBooked ? "disabled" : "" %>
                                        style="display:none"
                                    >
                                    <span class="inline-block w-10 h-10 text-center align-middle leading-10 rounded
                                        <%= isBooked ? "bg-gray-400 text-white" : "bg-green-500 text-white peer-checked:bg-blue-600" %>
                                        border border-gray-500 font-bold transition">
                                        <%= seatValue %>
                                    </span>
                                </label>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </div>
                <div class="mt-2 text-sm">
                    <span class="inline-block w-4 h-4 bg-green-500 rounded align-middle"></span> Available
                    <span class="inline-block w-4 h-4 bg-blue-600 rounded align-middle ml-4"></span> Selected
                    <span class="inline-block w-4 h-4 bg-gray-400 rounded align-middle ml-4"></span> Booked
                </div>
            </div>
            <button class="bg-green-600 px-4 py-2 text-white rounded hover:bg-blue-700 transition" type="submit">
                Book Now
            </button>
            <% if(request.getParameter("error") != null) { %>
                <div class="mt-2 text-red-500 text-center">
                    <% if("seat_taken".equals(request.getParameter("error"))) { %>
                        Selected seat is already booked. Please choose another!
                    <% } else { %>
                        Booking failed! Please try again.
                    <% } %>
                </div>
            <% } %>
        </form>
        <a href="dashboard.jsp" class="block mt-6 text-center text-blue-600 hover:underline">Back to Movies</a>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>