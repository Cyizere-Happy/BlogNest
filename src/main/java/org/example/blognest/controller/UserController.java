package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.User;
import org.example.blognest.services.CaptchaService;
import org.example.blognest.services.TOTPService;
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
        } else if ("verify2FA".equals(action)) {
            User pendingUser = (User) req.getSession().getAttribute("pending2FAUser");
            if (pendingUser == null) {
                resp.sendRedirect("auth");
                return;
            }
            req.setAttribute("is2FA", true);
            req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
        } else if ("regenerateSecret".equals(action)) {
            User pendingUser = (User) req.getSession().getAttribute("pending2FAUser");
            if (pendingUser != null) {
                String newSecret = TOTPService.generateSecret();
                pendingUser.setTwoFactorSecret(newSecret);
                userService.updateUser(pendingUser);
                req.getSession().setAttribute("toastMessage", "New Base32 secret generated. Please add it to your app.");
                req.getSession().setAttribute("toastType", "info");
                resp.sendRedirect("auth?action=verify2FA");
            } else {
                resp.sendRedirect("auth");
            }
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
            String captcha = req.getParameter("captcha");
            
            // Basic Validation & Security
            if (name == null || name.trim().isEmpty() || 
                email == null || email.trim().isEmpty() || 
                pass == null || pass.trim().isEmpty() ||
                captcha == null || captcha.trim().isEmpty()) {
                req.setAttribute("error", "All fields, including captcha, are required.");
                req.setAttribute("isSignup", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            // Captcha Verification
            if (!CaptchaService.verifyCaptcha(req.getSession(), captcha, "register")) {
                req.setAttribute("error", "Incorrect Captcha. Please try again.");
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
            String captcha = req.getParameter("captcha");
            
            if (email == null || email.trim().isEmpty() || pass == null || pass.trim().isEmpty() || captcha == null) {
                req.setAttribute("error", "Please provide email, password, and captcha.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            // Captcha Verification
            if (!CaptchaService.verifyCaptcha(req.getSession(), captcha, "login")) {
                req.setAttribute("error", "Incorrect Captcha.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            User user = userService.authenticate(email.trim(), pass);
            
            if (user != null) {
                if (user.isTwoFactorEnabled()) {
                    req.getSession().setAttribute("pending2FAUser", user);
                    resp.sendRedirect("auth?action=verify2FA");
                } else {
                    completeLogin(req, resp, user);
                }
            } else {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Login Failed");
                req.setAttribute("toastMessage", "Invalid email or password.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        } else if ("verify2FA".equals(action)) {
            String code = req.getParameter("code");
            User pendingUser = (User) req.getSession().getAttribute("pending2FAUser");
            
            if (pendingUser != null && TOTPService.verifyCode(pendingUser.getTwoFactorSecret(), code)) {
                req.getSession().removeAttribute("pending2FAUser");
                completeLogin(req, resp, pendingUser);
            } else {
                req.setAttribute("error", "Invalid 2FA code.");
                req.setAttribute("is2FA", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        } else if ("toggle2FA".equals(action)) {
            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                boolean enable = "true".equals(req.getParameter("enable"));
                if (enable) {
                    String secret = TOTPService.generateSecret();
                    user.setTwoFactorSecret(secret);
                    user.setTwoFactorEnabled(true);
                    req.getSession().setAttribute("toastMessage", "2FA has been enabled. Your secret is: " + secret);
                } else {
                    user.setTwoFactorEnabled(false);
                    user.setTwoFactorSecret(null);
                    req.getSession().setAttribute("toastMessage", "2FA has been disabled.");
                }
                userService.updateUser(user);
                req.getSession().setAttribute("toastType", "success");
                req.getSession().setAttribute("toastTitle", "Security Updated");
                resp.sendRedirect("admin?section=profile"); // Or wherever the profile is
            }
        }
    }

    private void completeLogin(HttpServletRequest req, HttpServletResponse resp, User user) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("user", user);
        session.setAttribute("toastType", "success");
        session.setAttribute("toastTitle", "Welcome back!");
        session.setAttribute("toastMessage", "You have successfully logged in.");

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("admin");
        } else {
            resp.sendRedirect("blog");
        }
    }
}
