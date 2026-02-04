package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.Post;
import org.example.blognest.model.User;
import org.example.blognest.services.PostService;
import java.io.IOException;
import java.util.List;

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
                    postService.incrementViews(id);
                    req.setAttribute("post", post);

                    // Fetch other stories for sidebar
                    List<Post> allPosts = postService.getAllPosts();
                    List<Post> otherPosts = allPosts.stream()
                            .filter(p -> !p.getId().equals(id))
                            .limit(3)
                            .toList();
                    req.setAttribute("otherPosts", otherPosts);

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
                
                HttpSession session = req.getSession();
                session.setAttribute("toastType", "success");
                session.setAttribute("toastTitle", "Success!");
                session.setAttribute("toastMessage", "Your comment has been submitted.");
                
                resp.sendRedirect("read_blog?id=" + postId);
                return;
                } catch(NumberFormatException e) {

                }
            }
        } else {
            resp.sendRedirect("auth");
        }

         String referer = req.getHeader("Referer");
         if(referer != null) resp.sendRedirect(referer);
         else resp.sendRedirect("blog");
    }
}