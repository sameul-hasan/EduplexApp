<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DIU EduPlex</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-b from-green-400 to-blue-600 min-h-screen">
    <div class="flex flex-col items-center justify-center min-h-screen">
        <img src="assets/logo.png" alt="DIU Logo" class="w-32 mb-6">
        <h1 class="text-4xl font-bold text-white mb-4">Kazi Nazrul Islam EduPlex</h1>
        <div class="space-x-4">
            <a href="jsp/common/login.jsp" class="bg-blue-700 text-white px-6 py-2 rounded hover:bg-green-600 transition">Login</a>
            <a href="jsp/common/register.jsp" class="bg-green-600 text-white px-6 py-2 rounded hover:bg-blue-700 transition">Register</a>
        </div>
    </div>
</body>
</html>