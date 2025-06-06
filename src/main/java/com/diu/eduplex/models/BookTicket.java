package com.diu.eduplex.models;

import java.util.Date;

public class BookTicket {
    private int noOfTicketsAvailable;  // Number of Available Tickets
    private String movieName;          // Movie Name
    private int showNo;                // Show Number
    private Date date;                 // Show Date
    private Date time;                 // Show Time
    private String venue;              // Venue

    // Constructor
    public BookTicket(int noOfTicketsAvailable, String movieName, int showNo, Date date, Date time, String venue) {
        this.noOfTicketsAvailable = noOfTicketsAvailable;
        this.movieName = movieName;
        this.showNo = showNo;
        this.date = date;
        this.time = time;
        this.venue = venue;
    }

    // Getters and Setters
    public int getNoOfTicketsAvailable() {
        return noOfTicketsAvailable;
    }

    public void setNoOfTicketsAvailable(int noOfTicketsAvailable) {
        this.noOfTicketsAvailable = noOfTicketsAvailable;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public int getShowNo() {
        return showNo;
    }

    public void setShowNo(int showNo) {
        this.showNo = showNo;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    // Method to Update Tickets Available
    public void updateSeatsAvailable(int ticketsBooked) {
        this.noOfTicketsAvailable -= ticketsBooked;
    }
}