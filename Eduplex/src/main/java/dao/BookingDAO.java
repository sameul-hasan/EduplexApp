package dao;
import model.Booking;
import util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class BookingDAO {

    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, movie_id, seat) VALUES (?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getMovieId());
            ps.setString(3, booking.getSeat());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> getBookedSeatsForMovie(int movieId) {
        List<String> bookedSeats = new ArrayList<>();
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT seat FROM bookings WHERE movie_id=?")) {
            ps.setInt(1, movieId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String seat = rs.getString("seat");
                if (seat != null && !seat.isEmpty()) {
                    bookedSeats.add(seat);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return bookedSeats;
    }

    public boolean cancelBooking(int bookingId, int id) {
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM bookings WHERE id=? AND user_id=?")) {
            ps.setInt(1, bookingId);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}