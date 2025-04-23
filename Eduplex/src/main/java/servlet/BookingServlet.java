package servlet;

import dao.BookingDAO;
import dao.MovieDAO;
import model.Booking;
import model.Movie;
import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    private MovieDAO movieDAO = new MovieDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("book".equals(action)) {
                // Validate and sanitize inputs
                String movieIdParam = req.getParameter("movie_id");
                String seat = req.getParameter("seat");

                if (movieIdParam == null || !movieIdParam.matches("\\d+")) {
                    res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID");
                    return;
                }
                if (seat == null || seat.trim().isEmpty()) {
                    res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Seat cannot be empty");
                    return;
                }

                int movieId = Integer.parseInt(movieIdParam);
                HttpSession session = req.getSession();
                User user = (User) session.getAttribute("user");

                if (user != null) {
                    Booking booking = new Booking();
                    booking.setUserId(user.getId());
                    booking.setMovieId(movieId);
                    booking.setSeat(seat);

                    // Attempt to add the booking
                    if (bookingDAO.addBooking(booking)) {
                        Movie movie = movieDAO.getMovieById(movieId);
                        if (movie != null) {
                            // Attempt to send email confirmation
                            try {
                                util.MailUtil.sendConfirmation(user.getEmail(), movie.getTitle());
                            } catch (Exception e) {
                                System.err.println("Error sending confirmation email: " + e.getMessage());
                            }
                        }
                        res.sendRedirect("jsp/user/history.jsp?success=1");
                    } else {
                        res.sendRedirect("jsp/user/dashboard.jsp?error=1"); // Error during booking
                    }
                } else {
                    res.sendRedirect("jsp/common/login.jsp?error=2"); // User not logged in
                }
            } else if ("cancel".equals(action)) {
                String bookingIdParam = req.getParameter("booking_id");

                // Validate booking ID
                if (bookingIdParam == null || !bookingIdParam.matches("\\d+")) {
                    res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID");
                    return;
                }

                int bookingId = Integer.parseInt(bookingIdParam);
                HttpSession session = req.getSession();
                User user = (User) session.getAttribute("user");

                if (user != null && bookingDAO.cancelBooking(bookingId, user.getId())) {
                    res.sendRedirect("jsp/user/history.jsp?cancel=1"); // Booking canceled successfully
                } else {
                    res.sendRedirect("jsp/user/history.jsp?error=1"); // Failed to cancel booking
                }
            } else {
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }
}