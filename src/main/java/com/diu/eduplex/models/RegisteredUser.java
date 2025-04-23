package com.diu.eduplex.models;

public class RegisteredUser {
    private String id;
    private String name;
    private int phNo;
    private String address;

    // Constructor
    public RegisteredUser(String id, String name, int phNo, String address) {
        this.id = id;
        this.name = name;
        this.phNo = phNo;
        this.address = address;
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

    public int getPhNo() {
        return phNo;
    }

    public void setPhNo(int phNo) {
        this.phNo = phNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // Methods
    public void login() {
        // Implementation for login
    }

    public void logout() {
        // Implementation for logout
    }

    public void viewMovies() {
        // Implementation for viewing movies
    }

    public void bookTicket() {
        // Implementation for booking ticket
    }

    public void makePayment() {
        // Implementation for making payment
    }

    public void cancelTicket() {
        // Implementation for canceling ticket
    }
}