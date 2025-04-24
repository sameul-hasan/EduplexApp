package com.diu.eduplex.models;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Movie {
    private int id;
    private String movieName;
    private String showDate;
    private String showTime;
    private String venue;
    private int noOfTicketsAvailable;
    private int showNo;

    // Constructor for existing movies from database
    public Movie(int id, String movieName, String showDate, String showTime, String venue, int noOfTicketsAvailable, int showNo) {
        this.id = id;
        this.movieName = movieName;
        this.showDate = showDate;
        this.showTime = showTime;
        this.venue = venue;
        this.noOfTicketsAvailable = noOfTicketsAvailable;
        this.showNo = showNo;
    }

    // Constructor for adding new movies
    public Movie(String movieName, String showDate, String showTime, String venue, int noOfTicketsAvailable, int showNo) {
        this.movieName = movieName;
        this.showDate = showDate;
        this.showTime = showTime;
        this.venue = venue;
        this.noOfTicketsAvailable = noOfTicketsAvailable;
        this.showNo = showNo;
    }

    // Constructor for backward compatibility
    public Movie(String movieName, Timestamp movieShow, String venue) {
        this.movieName = movieName;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        this.showDate = dateFormat.format(movieShow);
        this.showTime = timeFormat.format(movieShow);
        this.venue = venue;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getShowDate() {
        return showDate;
    }

    public void setShowDate(String showDate) {
        this.showDate = showDate;
    }

    public String getShowTime() {
        return showTime;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public int getNoOfTicketsAvailable() {
        return noOfTicketsAvailable;
    }

    public void setNoOfTicketsAvailable(int noOfTicketsAvailable) {
        this.noOfTicketsAvailable = noOfTicketsAvailable;
    }

    public int getShowNo() {
        return showNo;
    }

    public void setShowNo(int showNo) {
        this.showNo = showNo;
    }

    // For backward compatibility with existing code
    public Timestamp getMovieShow() {
        try {
            return Timestamp.valueOf(showDate + " " + showTime);
        } catch (Exception e) {
            return new Timestamp(System.currentTimeMillis());
        }
    }

    // Update movie details
    public void updateDetails(String movieName, String showDate, String showTime, String venue, int noOfTicketsAvailable, int showNo) {
        this.movieName = movieName;
        this.showDate = showDate;
        this.showTime = showTime;
        this.venue = venue;
        this.noOfTicketsAvailable = noOfTicketsAvailable;
        this.showNo = showNo;
    }
}