package com.diu.eduplex.models;

public class Visitor {
    private String name;

    // Constructor
    public Visitor(String name) {
        this.name = name;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Methods
    public void getRegistered() {
        // Implementation for visitor registration
    }

    public void viewMovies() {
        // Implementation for viewing movies
    }
}