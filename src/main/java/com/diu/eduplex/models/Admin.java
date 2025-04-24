package com.diu.eduplex.models;

public class Admin {
    private String id;
    private String name;
    private String password;

    // Constructor
    public Admin(String id, String name, String password) {
        this.id = id;
        this.name = name;
        this.password = password;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Methods
    public void addMovieRecords(Movie movie) {
        // Implementation for adding movie records
    }

    public void updateMovieRecords(Movie movie) {
        // Implementation for updating movie records
    }

    public void deleteMovieRecords(Movie movie) {
        // Implementation for deleting movie records
    }
}