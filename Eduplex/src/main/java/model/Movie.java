package model;

import java.util.Date;

public class Movie {
    private int id;
    private String title;
    private String description;
    private String poster;
    private Date showTime;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public Date getShowTime() { return showTime; }
    public void setShowTime(Date showTime) { this.showTime = showTime; }
}