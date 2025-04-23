package com.diu.eduplex.models;

import java.util.Date;

public class Movie {
    private String movieName;
    private Date movieShow;
    private String venue;

    // Constructor
    public Movie(String movieName, Date movieShow, String venue) {
        this.movieName = movieName;
        this.movieShow = movieShow;
        this.venue = venue;
    }

    // Getters and Setters
    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public Date getMovieShow() {
        return movieShow;
    }

    public void setMovieShow(Date movieShow) {
        this.movieShow = movieShow;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    // Update movie details
    public void updateDetails(String movieName, Date movieShow, String venue) {
        this.movieName = movieName;
        this.movieShow = movieShow;
        this.venue = venue;
    }
}