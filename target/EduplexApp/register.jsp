<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Registration</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h1 class="text-2xl font-bold mb-6 text-center text-gray-800">Register</h1>
        <form id="registerForm" action="user" method="post" class="space-y-4">
            <input type="hidden" name="action" value="register">
            <div>
                <label for="userId" class="block text-sm font-medium text-gray-700">User ID</label>
                <input type="text" id="userId" name="userId" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p id="userIdError" class="text-red-500 text-sm"></p>
            </div>
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700">Name</label>
                <input type="text" id="name" name="name" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p id="passwordError" class="text-red-500 text-sm"></p>
            </div>
            <div>
                <label for="phone" class="block text-sm font-medium text-gray-700">Phone</label>
                <input type="text" id="phone" name="phone" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                <input type="text" id="address" name="address"
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <button type="submit"
                    class="w-full bg-blue-600 text-white py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                Register
            </button>
        </form>
        <p class="text-red-500 text-sm mt-4">
            <%= request.getParameter("error") != null ? request.getParameter("error") : "" %>
        </p>
    </div>

    <script>
        document.getElementById('registerForm').addEventListener('submit', function(event) {
            let isValid = true;

            // Validate User ID
            const userId = document.getElementById('userId');
            const userIdError = document.getElementById('userIdError');
            if (userId.value.trim() === '') {
                userIdError.textContent = 'User ID is required.';
                isValid = false;
            } else {
                userIdError.textContent = '';
            }

            // Validate Password
            const password = document.getElementById('password');
            const passwordError = document.getElementById('passwordError');
            if (password.value.trim().length < 6) {
                passwordError.textContent = 'Password must be at least 6 characters.';
                isValid = false;
            } else {
                passwordError.textContent = '';
            }

            if (!isValid) {
                event.preventDefault(); // Prevent form submission
            }
        });
    </script>
</body>
</html>