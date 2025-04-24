<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Invalidate the session to log out the user
    session.invalidate();
    // Redirect to the home page
    response.sendRedirect("index.jsp");
%>