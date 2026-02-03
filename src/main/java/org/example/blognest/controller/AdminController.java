package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.Post;
import org.example.blognest.model.User;
import org.example.blognest.services.PostService;
import org.example.blognest.services.UserService;
import org.example.blognest.services.CommentService;

import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private final PostService postService = PostService.getInstance();
    private final UserService userService = UserService.getInstance();
    private final CommentService commentService = CommentService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "ADMIN".equals(user.getRole())) {
            
            // Fetch data for the dashboard
            req.setAttribute("users", userService.getAllUsers());
            req.setAttribute("posts", postService.getAllPosts());
            req.setAttribute("comments", commentService.getAllComments());
            
            // Calculate basic stats
            int totalViews = postService.getAllPosts().stream().mapToInt(Post::getViews).sum();
            req.setAttribute("totalViews", totalViews);
            req.setAttribute("totalPosts", postService.getAllPosts().size());
            req.setAttribute("totalUsers", userService.getAllUsers().size());
            
            // Check for cross-page edit request
            String editId = req.getParameter("editId");
            if (editId != null) {
                try {
                    Post editPost = postService.getPostById(Long.parseLong(editId));
                    if (editPost != null) {
                        req.setAttribute("editPost", editPost);
                    }
                } catch (NumberFormatException ignored) {}
            }
            
            req.getRequestDispatcher("/WEB-INF/Admin.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("auth");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = (User) req.getSession().getAttribute("user");
        if (user != null && "ADMIN".equals(user.getRole())) {
            String action = req.getParameter("action");
            
            if ("createPost".equals(action)) {
                String title = req.getParameter("title");
                String content = req.getParameter("content");
                String category = req.getParameter("category");
                String desc = req.getParameter("description");
                String thumb = req.getParameter("thumbnail_url");

                if(title != null && content != null) {
                     Post post = new Post(title, desc, content, category, user);
                     post.setThumbnail_url(thumb);
                     postService.createPost(post);
                }
            } else if ("updatePost".equals(action)) {
                Long id = Long.parseLong(req.getParameter("postId"));
                String title = req.getParameter("title");
                String content = req.getParameter("content");
                String category = req.getParameter("category");
                String desc = req.getParameter("description");
                String thumb = req.getParameter("thumbnail_url");

                Post post = postService.getPostById(id);
                if (post != null) {
                    post.setTitle(title);
                    post.setContent(content);
                    post.setCategory(category);
                    post.setDescription(desc);
                    post.setThumbnail_url(thumb);
                    postService.updatePost(post);
                }
            } else if ("deletePost".equals(action)) {
                Long id = Long.parseLong(req.getParameter("postId"));
                postService.deletePost(id);
            } else if ("approveComment".equals(action)) {
                Long id = Long.parseLong(req.getParameter("commentId"));
                commentService.approveComment(id);
            } else if ("deleteComment".equals(action)) {
                Long id = Long.parseLong(req.getParameter("commentId"));
                commentService.deleteComment(id);
            }
            
            resp.sendRedirect("admin");
        } else {
            resp.sendRedirect("auth");
        }
    }
}
