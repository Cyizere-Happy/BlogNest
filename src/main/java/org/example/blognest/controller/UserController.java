package org.example.blognest.controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.blognest.model.User;
import org.example.blognest.services.UserService;


import java.io.IOException;

@WebServlet(name = "UserController", value = "/auth")
public class UserController extends HttpServlet {
    private final UserService userService = UserService.getInstance();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String confirmPassword = request.getParameter("confirm_password");

        // Basic validation
        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/WEB-INF/auth.jsp").forward(request, response);
            return;
        }

        User user = new User(name, email, password);
        userService.addUser(user);

        // redirect after successful registration
        response.sendRedirect(request.getContextPath() + "/auth");
    }

}
