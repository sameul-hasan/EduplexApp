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
                <li class="flex items-center justify-between">
                    <span>Movie A (5 tickets available)</span>
                    <button class="bg-blue-600 text-white px-4 py-1 rounded-md hover:bg-blue-700 transition">Book Now</button>
                </li>
                <li class="flex items-center justify-between">
                    <span>Movie B (8 tickets available)</span>
                    <button class="bg-blue-600 text-white px-4 py-1 rounded-md hover:bg-blue-700 transition">Book Now</button>
                </li>
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
                    <tr>
                        <td class="border-b py-2">Movie A</td>
                        <td class="border-b py-2">2025-04-20</td>
                        <td class="border-b py-2">4</td>
                    </tr>
                    <tr>
                        <td class="border-b py-2">Movie B</td>
                        <td class="border-b py-2">2025-04-18</td>
                        <td class="border-b py-2">2</td>
                    </tr>
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
                    <tr>
                        <td class="border-b py-2">12345</td>
                        <td class="border-b py-2">2025-04-20</td>
                        <td class="border-b py-2">$50</td>
                    </tr>
                    <tr>
                        <td class="border-b py-2">67890</td>
                        <td class="border-b py-2">2025-04-18</td>
                        <td class="border-b py-2">$30</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>