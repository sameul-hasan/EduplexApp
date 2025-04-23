<!DOCTYPE html>
<html>
<head>
    <title>Eduplex - Payment Confirmation</title>
</head>
<body>
    <h1>Payment Status</h1>
    <p>
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
        Payment successful! Your transaction has been completed.
        <%
            } else {
        %>
        Payment failed. Please try again.
        <%
            }
        %>
    </p>
    <a href="movies.jsp">Back to Movies</a>
</body>
</html>