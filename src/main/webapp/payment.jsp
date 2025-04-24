<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Payment</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen">
    <div class="container mx-auto py-10 px-4">
        <h1 class="text-3xl font-bold text-center text-gray-800 mb-10">Complete Your Payment</h1>

        <div class="max-w-md mx-auto bg-white rounded-lg shadow-lg p-6">
            <% if(request.getParameter("error") != null) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                    <%= request.getParameter("error") %>
                </div>
            <% } %>

            <div class="mb-6 p-4 bg-gray-50 rounded-md">
                <h2 class="text-lg font-bold text-gray-800 mb-2">Order Summary</h2>
                <p class="text-gray-700"><strong>Movie:</strong> <%= request.getAttribute("movieName") %></p>
                <p class="text-gray-700"><strong>Date:</strong> <%= request.getAttribute("showDate") %></p>
                <p class="text-gray-700"><strong>Time:</strong> <%= request.getAttribute("showTime") %></p>
                <p class="text-gray-700"><strong>Venue:</strong> <%= request.getAttribute("venue") %></p>
                <p class="text-gray-700"><strong>Tickets:</strong> <%= request.getAttribute("numTickets") %></p>
                <p class="text-lg font-bold text-blue-600 mt-2">Total: $<%= request.getAttribute("amount") %></p>
            </div>

            <form action="booking" method="post" id="paymentForm" class="space-y-4">
                <input type="hidden" name="action" value="processPayment">

                <div>
                    <label for="cardNumber" class="block text-sm font-medium text-gray-700">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required
                           class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label for="expiryDate" class="block text-sm font-medium text-gray-700">Expiry Date</label>
                        <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                    <div>
                        <label for="cvv" class="block text-sm font-medium text-gray-700">CVV</label>
                        <input type="text" id="cvv" name="cvv" placeholder="123" required
                               class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <div>
                    <label for="cardholderName" class="block text-sm font-medium text-gray-700">Cardholder Name</label>
                    <input type="text" id="cardholderName" name="cardholderName" required
                           class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>

                <button type="submit"
                        class="w-full bg-blue-600 text-white py-3 rounded-md shadow-md hover:bg-blue-700 transition text-lg font-medium">
                    Pay $<%= request.getAttribute("amount") %>
                </button>
            </form>

            <div class="mt-4 text-center">
                <a href="movies" class="text-blue-600 hover:underline">Cancel Payment</a>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            // This is a demo, so we'll just validate that fields are filled in a simple way
            // In a real app, you'd have more robust validation

            const cardNumber = document.getElementById('cardNumber').value.replace(/\s/g, '');
            if (!/^\d{16}$/.test(cardNumber)) {
                e.preventDefault();
                alert('Please enter a valid 16-digit card number');
                return;
            }

            const expiryDate = document.getElementById('expiryDate').value;
            if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
                e.preventDefault();
                alert('Please enter a valid expiry date in MM/YY format');
                return;
            }

            const cvv = document.getElementById('cvv').value;
            if (!/^\d{3}$/.test(cvv)) {
                e.preventDefault();
                alert('Please enter a valid 3-digit CVV');
                return;
            }
        });

        // Format card number as user types
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 16) value = value.slice(0, 16);

            // Add spaces for readability
            const parts = [];
            for (let i = 0; i < value.length; i += 4) {
                parts.push(value.slice(i, i + 4));
            }
            e.target.value = parts.join(' ');
        });

        // Format expiry date as user types
        document.getElementById('expiryDate').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 4) value = value.slice(0, 4);

            if (value.length > 2) {
                e.target.value = value.slice(0, 2) + '/' + value.slice(2);
            } else {
                e.target.value = value;
            }
        });

        // Limit CVV to 3 digits
        document.getElementById('cvv').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 3) value = value.slice(0, 3);
            e.target.value = value;
        });
    </script>
</body>
</html>