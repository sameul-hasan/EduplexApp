<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h1 class="text-2xl font-bold mb-6 text-center text-gray-800">Login</h1>
        <form id="loginForm" action="user" method="post" class="space-y-4">
            <input type="hidden" name="action" value="login">
            <div>
                <label for="userId" class="block text-sm font-medium text-gray-700">User ID</label>
                <input type="text" id="userId" name="userId" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p id="userIdError" class="text-red-500 text-sm"></p>
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <p id="passwordError" class="text-red-500 text-sm"></p>
            </div>
            <button type="submit"
                    class="w-full bg-blue-600 text-white py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                Login
            </button>
        </form>
        <p class="text-red-500 text-sm mt-4">
            <%= request.getParameter("error") != null ? request.getParameter("error") : "" %>
        </p>
        <p class="text-center text-sm mt-4">
            Don't have an account?
            <a href="register.jsp" class="text-blue-600 hover:underline">Register here</a>
        </p>
    </div>

    <script>
        document.getElementById('loginForm').addEventListener('submit', function(event) {
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
            if (password.value.trim() === '') {
                passwordError.textContent = 'Password is required.';
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