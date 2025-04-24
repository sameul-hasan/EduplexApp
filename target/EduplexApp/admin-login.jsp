<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Admin Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white shadow-lg rounded-lg p-8 w-full max-w-md">
        <h1 class="text-2xl font-bold mb-6 text-center text-gray-800">Admin Login</h1>
        <form id="loginForm" action="admin" method="post" class="space-y-4">
            <input type="hidden" name="action" value="login">
            <div>
                <label for="userId" class="block text-sm font-medium text-gray-700">Admin ID</label>
                <input type="text" id="userId" name="userId" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <button type="submit"
                    class="w-full bg-blue-600 text-white py-2 rounded-md shadow-md hover:bg-blue-700 transition">
                Login
            </button>
        </form>
        <% if(request.getParameter("error") != null) { %>
            <p class="text-red-500 text-sm mt-4"><%= request.getParameter("error") %></p>
        <% } %>
        <p class="text-center text-sm mt-4">
            <a href="index.jsp" class="text-blue-600 hover:underline">Back to Home</a>
        </p>
    </div>
</body>
</html>