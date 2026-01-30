package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.User;
import org.example.blognest.services.UserService;
import java.io.IOException;

@WebServlet(name = "UserController", value = "/auth")
public class UserController extends HttpServlet {
    private final UserService userService = UserService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            req.getSession().invalidate();
            resp.sendRedirect("auth");
        } else {
            req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        
        if ("register".equals(action)) {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            
            // Basic validation removed for brevity, rely on frontend or add later
            userService.addUser(new User(name, email, pass));
            resp.sendRedirect("auth"); // Redirect to login page (which is the same auth page)
        } else if ("login".equals(action)) {
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            
            User user = userService.authenticate(email, pass);
            
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                // Redirect to profile or blog? Usage suggests blog is the main feed.
                resp.sendRedirect("blog");
            } else {
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        }
    }
}
