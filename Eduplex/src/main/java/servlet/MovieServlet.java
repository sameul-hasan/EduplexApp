package servlet;

import dao.MovieDAO;
import model.Movie;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/movie")
public class MovieServlet extends HttpServlet {
    private MovieDAO movieDAO = new MovieDAO();

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            String title = req.getParameter("title");
            String desc = req.getParameter("description");
            String poster = req.getParameter("poster");
            String showTime = req.getParameter("show_time");
            try {
                Movie movie = new Movie();
                movie.setTitle(title);
                movie.setDescription(desc);
                movie.setPoster(poster);
                movie.setShowTime(java.sql.Timestamp.valueOf(showTime.replace("T", " ") + ":00"));
                if (movieDAO.addMovie(movie)) {
                    res.sendRedirect("jsp/admin/dashboard.jsp?success=1");
                } else {
                    res.sendRedirect("jsp/admin/add_movie.jsp?error=1");
                }
            } catch (Exception e) {
                res.sendRedirect("jsp/admin/add_movie.jsp?error=1");
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            if (movieDAO.deleteMovie(id)) {
                res.sendRedirect("jsp/admin/dashboard.jsp?deleted=1");
            } else {
                res.sendRedirect("jsp/admin/dashboard.jsp?error=1");
            }
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String title = req.getParameter("title");
            String desc = req.getParameter("description");
            String poster = req.getParameter("poster");
            String showTime = req.getParameter("show_time");
            Movie movie = new Movie();
            movie.setId(id);
            movie.setTitle(title);
            movie.setDescription(desc);
            movie.setPoster(poster);
            try {
                movie.setShowTime(java.sql.Timestamp.valueOf(showTime.replace("T", " ") + ":00"));
            } catch (Exception e) {
                movie.setShowTime(new java.util.Date());
            }
            if (movieDAO.updateMovie(movie)) {
                res.sendRedirect("jsp/admin/dashboard.jsp?updated=1");
            } else {
                res.sendRedirect("jsp/admin/edit_movie.jsp?id=" + id + "&error=1");
            }
        }
    }
}