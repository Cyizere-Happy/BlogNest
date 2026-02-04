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
            
            // Basic Validation & Security
            if (name == null || name.trim().isEmpty() || 
                email == null || email.trim().isEmpty() || 
                pass == null || pass.trim().isEmpty()) {
                req.setAttribute("error", "All fields are required.");
                req.setAttribute("isSignup", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            // Check if user already exists
            if (userService.getUserByEmail(email.trim()) != null) {
                req.setAttribute("error", "An account with this email already exists.");
                req.setAttribute("isSignup", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }
            
            try {
                User newUser = new User(name.trim(), email.trim(), pass);
                userService.addUser(newUser);
                req.setAttribute("success", "Registration successful! Please login.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            } catch (Exception e) {
                req.setAttribute("error", "An unexpected error occurred. Please try again.");
                req.setAttribute("isSignup", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        } else if ("login".equals(action)) {
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            
            if (email == null || email.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
                req.setAttribute("error", "Please provide both email and password.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            User user = userService.authenticate(email.trim(), pass);
            
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                if("ADMIN".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect("admin");
                } else {
                    resp.sendRedirect("blog");
                }
            } else {
                req.setAttribute("error", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        }
    }
}
