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
            HttpSession session = req.getSession();
            session.removeAttribute("user");
            session.setAttribute("toastType", "success");
            session.setAttribute("toastTitle", "Goodbye!");
            session.setAttribute("toastMessage", "You have been logged out successfully.");
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
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Registration Error");
                req.setAttribute("toastMessage", "An account with this email already exists.");
                req.setAttribute("isSignup", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }
            
            // Using 3-arg constructor. Role defaults to "USER" in the Model.
            User newUser = new User(name.trim(), email.trim(), pass);
            if (userService.addUser(newUser)) {
                req.getSession().setAttribute("toastType", "success");
                req.getSession().setAttribute("toastTitle", "Account Created!");
                req.getSession().setAttribute("toastMessage", "Welcome to BlogNest! You can now log in.");
                resp.sendRedirect("auth");
            } else {
                req.setAttribute("error", "An error occurred. Please try again.");
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
                session.setAttribute("toastType", "success");
                session.setAttribute("toastTitle", "Welcome back!");
                session.setAttribute("toastMessage", "You have successfully logged in.");

                if("ADMIN".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect("admin");
                } else {
                    resp.sendRedirect("blog");
                }
            } else {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Login Failed");
                req.setAttribute("toastMessage", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        }
    }
}
