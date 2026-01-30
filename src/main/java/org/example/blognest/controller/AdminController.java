package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.Post;
import org.example.blognest.model.User;
import org.example.blognest.services.PostService;
import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private final PostService postService = PostService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "ADMIN".equals(user.getRole())) {
            req.getRequestDispatcher("/WEB-INF/admin.html").forward(req, resp);
        } else {
            resp.sendRedirect("auth");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "ADMIN".equals(user.getRole())) {
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            String category = req.getParameter("category");
            String desc = req.getParameter("description");
            String thumb = req.getParameter("thumbnail_url");

            // Basic validation
            if(title != null && content != null) {
                 Post post = new Post(title, desc, content, category, user);
                 post.setThumbnail_url(thumb);
                 postService.createPost(post);
            }
            resp.sendRedirect("blog");
        } else {
            resp.sendRedirect("auth");
        }
    }
}
