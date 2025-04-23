<%@ page session="true" import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    boolean isAdmin = (user != null && user.isAdmin());
%>
<nav class="bg-gradient-to-r from-green-500 to-blue-600 p-4 flex justify-between items-center mb-6">
    <div class="flex items-center space-x-3">
        <img src="../../assets/logo.png" class="w-10 h-10 rounded">
        <span class="text-white text-xl font-bold">DIU EduPlex</span>
    </div>
    <div class="space-x-4">
        <% if(user == null) { %>
            <a href="../../jsp/common/login.jsp" class="text-white hover:underline">Login</a>
            <a href="../../jsp/common/register.jsp" class="text-white hover:underline">Register</a>
        <% } else if(isAdmin) { %>
            <a href="../../jsp/admin/dashboard.jsp" class="text-white hover:underline">Dashboard</a>
            <a href="../../jsp/admin/users.jsp" class="text-white hover:underline">Users</a>
            <a href="../../jsp/admin/bookings.jsp" class="text-white hover:underline">Bookings</a>
            <a href="../../logout" class="text-white hover:underline">Logout</a>
        <% } else { %>
            <a href="../../jsp/user/dashboard.jsp" class="text-white hover:underline">Movies</a>
            <a href="../../jsp/user/history.jsp" class="text-white hover:underline">My Bookings</a>
            <a href="../../jsp/user/profile.jsp" class="text-white hover:underline">Profile</a>
            <a href="../../logout" class="text-white hover:underline">Logout</a>
        <% } %>
    </div>
</nav>