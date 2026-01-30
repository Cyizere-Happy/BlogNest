package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.Post;
import org.example.blognest.services.PostService;
import java.io.IOException;
import java.util.List;

@WebServlet("/stories")
public class StoriesController extends HttpServlet {
    private final PostService postService = PostService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Post> posts = postService.getAllPosts();
        req.setAttribute("posts", posts);
        req.getRequestDispatcher("/WEB-INF/Blogs.jsp").forward(req, resp);
    }
}
