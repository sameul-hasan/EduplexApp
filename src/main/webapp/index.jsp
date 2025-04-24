<!DOCTYPE html>
<html lang="en">
<head>
    <title>Eduplex - Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .fade-in {
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body class="bg-gradient-to-r from-blue-500 to-purple-600 text-white min-h-screen flex items-center justify-center">
    <div class="text-center fade-in">
        <h1 class="text-5xl font-bold mb-4">Welcome To </h1>
        <h2 class="text-5xl font-bold mb-4">Kazi Nazrul Islam EduPlex</h2>
        <h2 class="text-5xl font-bold mb-4">Daffodil International University</h2>
        <p class="text-lg mb-6">Book Movie Easily</p>
        <div class="space-x-4">
            <a href="login.jsp" class="bg-white text-blue-600 px-6 py-2 rounded-md shadow-md text-lg font-medium hover:bg-gray-200 transition">Login</a>
            <a href="movies" class="bg-white text-blue-600 px-6 py-2 rounded-md shadow-md text-lg font-medium hover:bg-gray-200 transition">View Movies</a>
            <a href="admin-login.jsp" class="bg-gray-800 text-white px-6 py-2 rounded-md shadow-md text-lg font-medium hover:bg-gray-700 transition">Admin</a>
        </div>
    </div>
</body>
</html>