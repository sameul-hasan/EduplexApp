<%@ page import="dao.BookingDAO,dao.UserDAO,dao.MovieDAO,model.Booking,model.User,model.Movie,java.util.List" %>
<%@ include file="../common/navbar.jsp" %>
<%
    BookingDAO bookingDAO = new BookingDAO();
    UserDAO userDAO = new UserDAO();
    MovieDAO movieDAO = new MovieDAO();
    List<Booking> bookings = bookingDAO.getAllBookings();
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Bookings - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-100 min-h-screen">
<div class="container mx-auto py-8">
    <h2 class="text-2xl font-bold mb-4">All Bookings</h2>
    <table class="min-w-full bg-white rounded shadow">
        <thead>
            <tr>
                <th class="py-2 px-4">Booking ID</th>
                <th class="py-2 px-4">User</th>
                <th class="py-2 px-4">Movie</th>
                <th class="py-2 px-4">Show Time</th>
                <th class="py-2 px-4">Booked At</th>
            </tr>
        </thead>
        <tbody>
            <% for(Booking b: bookings) {
                User u = userDAO.getUserByEmail(userDAO.getAllUsers().stream().filter(
                    x -> x.getId() == b.getUserId()).findFirst().map(User::getEmail).orElse(""));
                Movie m = movieDAO.getMovieById(b.getMovieId());
            %>
            <tr>
                <td class="py-2 px-4"><%= b.getId() %></td>
                <td class="py-2 px-4"><%= u != null ? u.getName() : "?" %></td>
                <td class="py-2 px-4"><%= m != null ? m.getTitle() : "?" %></td>
                <td class="py-2 px-4"><%= m != null ? m.getShowTime() : "?" %></td>
                <td class="py-2 px-4"><%= b.getBookedAt() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>