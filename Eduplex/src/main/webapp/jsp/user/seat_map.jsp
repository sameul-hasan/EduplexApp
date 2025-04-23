<%@ page import="dao.BookingDAO,java.util.List" %>
<%
    int movieId = Integer.parseInt(request.getParameter("movie_id"));
    BookingDAO bookingDAO = new BookingDAO();
    List<String> bookedSeats = bookingDAO.getBookedSeatsForMovie(movieId);
%>
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
    <button class="bg-green-600 px-4 py-2 text-white rounded hover:bg-blue-700 transition" type="submit">Book Now</button>
</form>