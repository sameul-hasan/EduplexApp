<%@ page import="model.User" %>
<%@ include file="../common/navbar.jsp" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile - EduPlex</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-green-100 min-h-screen flex items-center justify-center">
    <form action="../../profile" method="post" class="bg-white p-8 rounded shadow-md w-96">
        <h2 class="text-2xl font-bold mb-6 text-center">Update Profile</h2>
        <label>Name:</label>
        <input name="name" value="<%= user.getName() %>" class="w-full mb-3 p-2 border rounded" readonly>
        <label>Email:</label>
        <input name="email" value="<%= user.getEmail() %>" class="w-full mb-3 p-2 border rounded">
        <label>New Password:</label>
        <input name="password" type="password" placeholder="Leave blank to keep current"
               class="w-full mb-3 p-2 border rounded">
        <button class="bg-green-600 w-full py-2 rounded text-white font-bold hover:bg-blue-700 transition" type="submit">
            Update
        </button>
        <% if(request.getParameter("success") != null) { %>
            <div class="mt-2 text-green-700 text-center">Profile updated!</div>
        <% } %>
        <% if(request.getParameter("error") != null) { %>
            <div class="mt-2 text-red-500 text-center">Update failed!</div>
        <% } %>
    </form>
<%@ include file="../common/footer.jsp" %>
</body>
</html>