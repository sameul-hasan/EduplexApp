<%@ page import="dao.UserDAO,model.User,java.util.List" %>
<%@ include file="../common/navbar.jsp" %>
<%
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Users - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-green-100 min-h-screen">
<div class="container mx-auto py-8">
    <h2 class="text-2xl font-bold mb-4">All Users</h2>
    <table class="min-w-full bg-white rounded shadow">
        <thead>
            <tr>
                <th class="py-2 px-4">ID</th>
                <th class="py-2 px-4">Name</th>
                <th class="py-2 px-4">Email</th>
                <th class="py-2 px-4">Admin?</th>
            </tr>
        </thead>
        <tbody>
            <% for(User u: users) { %>
            <tr>
                <td class="py-2 px-4"><%= u.getId() %></td>
                <td class="py-2 px-4"><%= u.getName() %></td>
                <td class="py-2 px-4"><%= u.getEmail() %></td>
                <td class="py-2 px-4"><%= u.isAdmin() ? "Yes" : "No" %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
<%@ include file="../common/footer.jsp" %>
</body>
</html>