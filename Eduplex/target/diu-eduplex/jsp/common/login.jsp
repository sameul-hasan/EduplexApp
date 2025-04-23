<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - EduPlex</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-b from-green-400 to-blue-600 min-h-screen flex items-center justify-center">
    <form action="../../user" method="post" class="bg-white p-8 rounded shadow-md w-80">
        <input type="hidden" name="action" value="login">
        <img src="../../assets/logo.png" class="w-20 mx-auto mb-4">
        <h2 class="text-2xl font-bold text-center mb-6">Login</h2>
        <input name="email" type="email" required placeholder="Email" class="w-full mb-3 p-2 border rounded">
        <input name="password" type="password" required placeholder="Password" class="w-full mb-3 p-2 border rounded">
        <button class="bg-green-500 w-full py-2 rounded text-white font-bold hover:bg-blue-600 transition" type="submit">Login</button>
        <p class="text-center mt-4 text-sm">No account? <a href="register.jsp" class="text-blue-700">Register</a></p>
        <% if(request.getParameter("error") != null) { %>
            <div class="mt-2 text-red-500 text-center">Invalid credentials!</div>
        <% } %>
    </form>
</body>
</html>