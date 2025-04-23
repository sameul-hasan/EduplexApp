package dao;

import model.Movie;
import util.DBUtil;

import java.sql.*;
import java.util.*;

public class MovieDAO {
    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM movies")) {
            while (rs.next()) {
                Movie m = new Movie();
                m.setId(rs.getInt("id"));
                m.setTitle(rs.getString("title"));
                m.setDescription(rs.getString("description"));
                m.setPoster(rs.getString("poster"));
                m.setShowTime(rs.getTimestamp("show_time"));
                movies.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movies;
    }

    public Movie getMovieById(int id) {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT * FROM movies WHERE id=?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Movie m = new Movie();
                m.setId(rs.getInt("id"));
                m.setTitle(rs.getString("title"));
                m.setDescription(rs.getString("description"));
                m.setPoster(rs.getString("poster"));
                m.setShowTime(rs.getTimestamp("show_time"));
                return m;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addMovie(Movie movie) {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO movies(title, description, poster, show_time) VALUES (?, ?, ?, ?)")
        ) {
            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getDescription());
            ps.setString(3, movie.getPoster());
            ps.setTimestamp(4, new java.sql.Timestamp(movie.getShowTime().getTime()));
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMovie(int id) {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM movies WHERE id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateMovie(Movie movie) {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "UPDATE movies SET title=?, description=?, poster=?, show_time=? WHERE id=?")) {
            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getDescription());
            ps.setString(3, movie.getPoster());
            ps.setTimestamp(4, new java.sql.Timestamp(movie.getShowTime().getTime()));
            ps.setInt(5, movie.getId());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}