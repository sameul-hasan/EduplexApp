<!-- Add a column for Seat -->
<thead>
    <tr>
        <th class="py-2 px-4">Movie</th>
        <th class="py-2 px-4">Seat</th>
        <th class="py-2 px-4">Show Time</th>
        <th class="py-2 px-4">Booked At</th>
        <th class="py-2 px-4">Action</th>
    </tr>
</thead>
<tbody>
    <% for(Booking b: bookings) {
        Movie m = movieDAO.getMovieById(b.getMovieId());
    %>
    <tr>
        <td class="py-2 px-4"><%= m.getTitle() %></td>
        <td class="py-2 px-4"><%= b.getSeat() %></td>
        <td class="py-2 px-4"><%= m.getShowTime() %></td>
        <td class="py-2 px-4"><%= b.getBookedAt() %></td>
        <td class="py-2 px-4">
            <form action="../../booking" method="post" onsubmit="return confirm('Cancel this booking?');">
                <input type="hidden" name="action" value="cancel">
                <input type="hidden" name="booking_id" value="<%= b.getId() %>">
                <button class="bg-red-600 text-white px-3 py-1 rounded">Cancel</button>
            </form>
        </td>
    </tr>
    <% } %>
</tbody>
<!-- Add cancel success/error feedback -->
<% if(request.getParameter("cancel") != null) { %>
    <div class="mt-4 text-green-700 font-bold">Booking cancelled!</div>
<% } %>