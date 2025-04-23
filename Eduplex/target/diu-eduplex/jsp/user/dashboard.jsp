<!-- Inside the movie card, just before the 'Book Now' button -->
<form action="../../booking" method="post">
    <input type="hidden" name="action" value="book">
    <input type="hidden" name="movie_id" value="<%= m.getId() %>">
    <label class="block mb-2 text-sm font-bold text-gray-700">Select Seat:</label>
    <select name="seat" required class="w-full mb-2 p-1 border rounded">
        <option value="">Choose...</option>
        <% for(char row='A'; row<='C'; row++) for(int col=1; col<=5; col++) { %>
            <option value="<%= row + String.valueOf(col) %>"><%= row + String.valueOf(col) %></option>
        <% } %>
    </select>
    <button class="bg-green-600 px-4 py-2 text-white rounded hover:bg-blue-700 transition" type="submit">Book Now</button>
</form>