package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.Post;
import org.example.blognest.model.User;
import org.example.blognest.services.PostService;
import java.io.IOException;

@WebServlet("/read_blog")
public class ReadBlogController extends HttpServlet {
    private final PostService postService = PostService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Long id = Long.parseLong(idStr);
                Post post = postService.getPostById(id);
                if (post != null) {
                    req.setAttribute("post", post);
                    req.getRequestDispatcher("/WEB-INF/read_blog.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                // Ignore invalid ID
            }
        }
        resp.sendRedirect("blog");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null) {
            String postIdStr = req.getParameter("postId");
            String content = req.getParameter("content");
            
            if (postIdStr != null && content != null && !content.trim().isEmpty()) {
                try {
                Long postId = Long.parseLong(postIdStr);
                postService.addComment(postId, user.getId(), content);
                resp.sendRedirect("read_blog?id=" + postId);
                return;
                } catch(NumberFormatException e) {
                    // Ignore
                }
            }
        } else {
            resp.sendRedirect("auth");
        }
         // Fallback
         String referer = req.getHeader("Referer");
         if(referer != null) resp.sendRedirect(referer);
         else resp.sendRedirect("blog");
    }
}