<%@ page import="java.util.List, java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto py-6">
        <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">User Dashboard</h1>

        <!-- Section: Available Tickets -->
        <div class="bg-white shadow-lg rounded-lg p-6 mb-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Available Tickets</h2>
            <ul class="space-y-4">
                <%
                    List<Map<String, Object>> availableTickets = (List<Map<String, Object>>) request.getAttribute("availableTickets");
                    if (availableTickets != null) {
                        for (Map<String, Object> ticket : availableTickets) {
                %>
                <li class="flex items-center justify-between">
                    <span><%= ticket.get("title") %> (<%= ticket.get("tickets_available") %> tickets available)</span>
                    <form action="user" method="post">
                        <input type="hidden" name="action" value="book">
                        <input type="hidden" name="movieId" value="<%= ticket.get("id") %>">
                        <input type="number" name="tickets" min="1" max="<%= ticket.get("tickets_available") %>" required>
                        <button type="submit" class="bg-blue-600 text-white px-4 py-1 rounded-md hover:bg-blue-700 transition">Book Now</button>
                    </form>
                </li>
                <%
                        }
                    } else {
                %>
                <p>No movies available currently.</p>
                <% } %>
            </ul>
        </div>

        <!-- Section: Booking History -->
        <div class="bg-white shadow-lg rounded-lg p-6 mb-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Booking History</h2>
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr>
                        <th class="border-b py-2">Movie</th>
                        <th class="border-b py-2">Date</th>
                        <th class="border-b py-2">Tickets</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Map<String, Object>> bookingHistory = (List<Map<String, Object>>) request.getAttribute("bookingHistory");
                        if (bookingHistory != null) {
                            for (Map<String, Object> booking : bookingHistory) {
                    %>
                    <tr>
                        <td class="border-b py-2"><%= booking.get("title") %></td>
                        <td class="border-b py-2"><%= booking.get("date") %></td>
                        <td class="border-b py-2"><%= booking.get("tickets_booked") %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="3">No booking history available.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Section: Payment History -->
        <div class="bg-white shadow-lg rounded-lg p-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Payment History</h2>
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr>
                        <th class="border-b py-2">Transaction ID</th>
                        <th class="border-b py-2">Date</th>
                        <th class="border-b py-2">Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Map<String, Object>> paymentHistory = (List<Map<String, Object>>) request.getAttribute("paymentHistory");
                        if (paymentHistory != null) {
                            for (Map<String, Object> payment : paymentHistory) {
                    %>
                    <tr>
                        <td class="border-b py-2"><%= payment.get("transaction_id") %></td>
                        <td class="border-b py-2"><%= payment.get("date") %></td>
                        <td class="border-b py-2">$<%= payment.get("amount") %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="3">No payment history available.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>