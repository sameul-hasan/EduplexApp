package com.diu.eduplex.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/eduplexdb";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Default for XAMPP

    public static Connection getConnection() throws Exception {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.err.println("Database Connection Error: " + e.getMessage());
            throw e;
        }
    }
}