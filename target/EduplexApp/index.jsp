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
        .logo-container {
            max-width: 250px;
            margin: 0 auto 1.5rem;
        }
        .logo {
            filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.5));
            transition: transform 0.3s ease;
        }
        .logo:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body class="bg-gradient-to-r from-blue-500 to-purple-600 text-white min-h-screen flex items-center justify-center">
    <div class="text-center fade-in">
        <div class="logo-container">
            <img src="https://banner2.cleanpng.com/20180505/whw/avd8gmbwy.webp" alt="Eduplex Logo" class="logo w-full mx-auto mb-4">
        </div>
        <h1 class="text-5xl font-bold mb-4">Welcome To </h1>
        <h3 class="text-5xl font-bold mb-4">Kazi Nazrul Islam EduPlex</h3>
        <h5 class="text-5xl font-bold mb-4">Daffodil International University</h5>
        <p class="text-lg mb-6">Book Movie Easily</p>
        <div class="space-x-4">
            <a href="login.jsp" class="bg-white text-blue-600 px-6 py-2 rounded-md shadow-md text-lg font-medium hover:bg-gray-200 transition">Login</a>
            <a href="movies" class="bg-white text-blue-600 px-6 py-2 rounded-md shadow-md text-lg font-medium hover:bg-gray-200 transition">View Movies</a>
        </div>
    </div>
</body>
</html>