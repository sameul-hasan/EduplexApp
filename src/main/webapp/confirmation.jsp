<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Eduplex - Payment Confirmation</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="max-w-md w-full bg-white shadow-lg rounded-lg p-8">
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <div class="text-center">
                <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100 mb-4">
                    <svg class="h-8 w-8 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                </div>
                <h1 class="text-2xl font-bold text-gray-800 mb-4">Payment Successful</h1>

                <div class="bg-gray-50 p-4 rounded-md text-left mb-6">
                    <h2 class="font-bold text-gray-800 mb-2">Booking Details:</h2>
                    <p><strong>Movie:</strong> <%= request.getAttribute("movieName") %></p>
                    <p><strong>Date:</strong> <%= request.getAttribute("showDate") %></p>
                    <p><strong>Time:</strong> <%= request.getAttribute("showTime") %></p>
                    <p><strong>Venue:</strong> <%= request.getAttribute("venue") %></p>
                    <p><strong>Tickets:</strong> <%= request.getAttribute("numTickets") %></p>
                    <p><strong>Amount Paid:</strong> $<%= request.getAttribute("amount") %></p>
                    <p><strong>Transaction ID:</strong> <%= request.getAttribute("transactionId") %></p>
                </div>

                <p class="mb-6 text-gray-600">A confirmation has been sent to your phone. Please show this confirmation at the venue.</p>

                <div class="flex justify-center">
                    <a href="movies" class="bg-blue-600 text-white px-6 py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                        Browse More Movies
                    </a>
                </div>
            </div>
        <%
            } else {
        %>
            <div class="text-center">
                <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100 mb-4">
                    <svg class="h-8 w-8 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </div>
                <h1 class="text-2xl font-bold text-gray-800 mb-4">Payment Failed</h1>
                <p class="mb-6 text-gray-600">Sorry, your payment could not be processed. Please try again.</p>

                <div class="flex justify-center">
                    <a href="movies" class="bg-blue-600 text-white px-6 py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                        Back to Movies
                    </a>
                </div>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>