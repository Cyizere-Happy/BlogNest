package org.example.blognest.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.blognest.model.User;
import org.example.blognest.services.UserService;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/users-api")
public class UserApiController extends HttpServlet {
    private final UserService userService = UserService.getInstance();
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "ADMIN".equalsIgnoreCase(user.getRole())) {
            List<UserDTO> users = userService.getAllUsers().stream()
                    .filter(u -> !"ADMIN".equalsIgnoreCase(u.getRole()))
                    .map(u -> new UserDTO(u.getName(), u.getEmail()))
                    .collect(Collectors.toList());
            
            resp.setContentType("application/json");
            objectMapper.writeValue(resp.getWriter(), users);
        } else {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
        }
    }

    private static class UserDTO {
        public String name;
        public String email;
        public UserDTO(String name, String email) {
            this.name = name;
            this.email = email;
        }
    }
}
