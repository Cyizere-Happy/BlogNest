package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.User;
import org.example.blognest.services.CaptchaService;
import org.example.blognest.services.MailService;
import org.example.blognest.services.TOTPService;
import org.example.blognest.services.UserService;
import org.example.blognest.util.InputSanitizer;
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
            String name = InputSanitizer.sanitizePlain(req.getParameter("name"));
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            String captchaResponse = req.getParameter("g-recaptcha-response");
            
            // Basic Validation & Security
            if (email == null || email.trim().isEmpty() || pass == null || pass.isEmpty() || name == null || name.trim().isEmpty() || captchaResponse == null || captchaResponse.isEmpty()) {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Input Required");
                req.setAttribute("toastMessage", "Please fill in all the details.");
                req.setAttribute("isSignup", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            // reCAPTCHA Verification
            if (!CaptchaService.verifyReCaptcha(captchaResponse)) {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "reCAPTCHA Failed");
                req.setAttribute("toastMessage", "Please complete the reCAPTCHA correctly.");
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
            
            // Generate OTP for email verification
            String secret = TOTPService.generateSecret();
            String code = TOTPService.generateCode(secret, 300); // 5-minute window
            
            // Send email
            MailService.getInstance().sendEmail(email.trim(), 
                "Verify your BlogNest Account", 
                "Your verification code is: " + code + "\n\nThis code will expire in 5 minutes.");
            
            // Store registration data in session
            HttpSession session = req.getSession();
            session.setAttribute("pendingRegUser", newUser);
            session.setAttribute("pendingRegSecret", secret);
            
            req.setAttribute("isVerifyEmail", true);
            req.setAttribute("toastType", "success");
            req.setAttribute("toastTitle", "Check Your Email");
            req.setAttribute("toastMessage", "A verification code has been sent to " + email);
            req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
        } else if ("verifyRegistration".equals(action)) {
            HttpSession session = req.getSession();
            User pendingUser = (User) session.getAttribute("pendingRegUser");
            String secret = (String) session.getAttribute("pendingRegSecret");
            String otp = req.getParameter("otp");
            
            if (pendingUser != null && secret != null && TOTPService.verifyCode(secret, otp, 300)) {
                if (userService.addUser(pendingUser)) {
                    session.removeAttribute("pendingRegUser");
                    session.removeAttribute("pendingRegSecret");
                    session.setAttribute("toastType", "success");
                    session.setAttribute("toastTitle", "Account Created!");
                    session.setAttribute("toastMessage", "Email verified! You can now log in.");
                    resp.sendRedirect("auth");
                } else {
                    req.setAttribute("toastType", "error");
                    req.setAttribute("toastTitle", "Registration Error");
                    req.setAttribute("toastMessage", "An error occurred during registration.");
                    req.setAttribute("isVerifyEmail", true);
                    req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Invalid Code");
                req.setAttribute("toastMessage", "Invalid or expired verification code.");
                req.setAttribute("isVerifyEmail", true);
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        } else if ("login".equals(action)) {
            String email = req.getParameter("email");
            String pass = req.getParameter("password");
            String captchaResponse = req.getParameter("g-recaptcha-response");
            
            if (email == null || email.trim().isEmpty() || pass == null || pass.isEmpty() || captchaResponse == null || captchaResponse.isEmpty()) {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Input Required");
                req.setAttribute("toastMessage", "Please fill in all the details.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            // reCAPTCHA Verification
            if (!CaptchaService.verifyReCaptcha(captchaResponse)) {
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "reCAPTCHA Failed");
                req.setAttribute("toastMessage", "Please complete the reCAPTCHA correctly.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                return;
            }

            User user = userService.authenticate(email.trim(), pass);
            if (user != null) {
                if (user.isTwoFactorEnabled()) {
                    req.getSession().setAttribute("pending2FAUser", user);
                    req.setAttribute("is2FA", true);
                    req.setAttribute("toastType", "info");
                    req.setAttribute("toastTitle", "2FA Required");
                    req.setAttribute("toastMessage", "Please enter your 2FA code.");
                    req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
                } else {
                    HttpSession session = req.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("toastType", "success");
                    session.setAttribute("toastTitle", "Welcome Back!");
                    session.setAttribute("toastMessage", "Successfully logged in as " + user.getName());
                    resp.sendRedirect("blog");
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
                HttpSession session = req.getSession();
                session.setAttribute("user", pendingUser);
                session.removeAttribute("pending2FAUser");
                session.setAttribute("toastType", "success");
                session.setAttribute("toastTitle", "Identity Verified");
                session.setAttribute("toastMessage", "Welcome back, " + pendingUser.getName());
                resp.sendRedirect("blog");
            } else {
                req.setAttribute("is2FA", true);
                req.setAttribute("toastType", "error");
                req.setAttribute("toastTitle", "Verification Failed");
                req.setAttribute("toastMessage", "Invalid or expired 2FA code.");
                req.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(req, resp);
            }
        } else if ("verifyAndEnable2FA".equals(action)) {
            User user = (User) req.getSession().getAttribute("user");
            String code = req.getParameter("code");
            if (user != null && user.getTwoFactorSecret() != null && TOTPService.verifyCode(user.getTwoFactorSecret(), code)) {
                user.setTwoFactorEnabled(true);
                userService.updateUser(user);
                req.getSession().setAttribute("toastType", "success");
                req.getSession().setAttribute("toastTitle", "2FA Enabled");
                req.getSession().setAttribute("toastMessage", "Two-factor authentication is now active on your account.");
            } else {
                req.getSession().setAttribute("toastType", "error");
                req.getSession().setAttribute("toastTitle", "Verification Failed");
                req.getSession().setAttribute("toastMessage", "The 2FA code is incorrect. Please try again.");
            }
            resp.sendRedirect("admin?section=profile");
        } else if ("toggle2FA".equals(action)) {
            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                boolean enable = "true".equals(req.getParameter("enable"));
                if (enable) {
                    String secret = TOTPService.generateSecret();
                    user.setTwoFactorSecret(secret);
                    user.setTwoFactorEnabled(false); // Must verify first
                    req.getSession().setAttribute("toastMessage", "2FA secret generated. Please verify it to enable.");
                } else {
                    user.setTwoFactorEnabled(false);
                    user.setTwoFactorSecret(null);
                    req.getSession().setAttribute("toastMessage", "2FA has been disabled.");
                }
                userService.updateUser(user);
                req.getSession().setAttribute("toastType", "success");
                req.getSession().setAttribute("toastTitle", "Security Updated");
                resp.sendRedirect("admin?section=profile");
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
