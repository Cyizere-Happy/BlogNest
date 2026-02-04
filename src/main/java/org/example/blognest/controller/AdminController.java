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
            String targetSection = "dashboard";
            
            try {
                HttpSession session = req.getSession();
                if ("createPost".equals(action)) {
                    targetSection = "manage-posts";
                    String title = req.getParameter("title") != null ? req.getParameter("title").trim() : null;
                    String content = req.getParameter("content") != null ? req.getParameter("content").trim() : null;
                    String category = req.getParameter("category") != null ? req.getParameter("category").trim() : "";
                    String desc = req.getParameter("description") != null ? req.getParameter("description").trim() : "";
                    String thumb = req.getParameter("thumbnail_url") != null ? req.getParameter("thumbnail_url").trim() : "";

                    if(title != null && !title.isEmpty() && content != null && !content.isEmpty()) {
                         Post post = new Post(title, desc, content, category, user);
                         post.setThumbnail_url(thumb);
                         postService.createPost(post);
                         session.setAttribute("toastType", "success");
                         session.setAttribute("toastTitle", "Success!");
                         session.setAttribute("toastMessage", "Your story has been published.");
                    }
                } else if ("updatePost".equals(action)) {
                    targetSection = "manage-posts";
                    String postIdStr = req.getParameter("postId");
                    if (postIdStr != null) {
                        Long id = Long.parseLong(postIdStr);
                        String title = req.getParameter("title") != null ? req.getParameter("title").trim() : null;
                        String content = req.getParameter("content") != null ? req.getParameter("content").trim() : null;
                        String category = req.getParameter("category") != null ? req.getParameter("category").trim() : "";
                        String desc = req.getParameter("description") != null ? req.getParameter("description").trim() : "";
                        String thumb = req.getParameter("thumbnail_url") != null ? req.getParameter("thumbnail_url").trim() : "";

                        Post post = postService.getPostById(id);
                        if (post != null && title != null && !title.isEmpty() && content != null && !content.isEmpty()) {
                            post.setTitle(title);
                            post.setContent(content);
                            post.setCategory(category);
                            post.setDescription(desc);
                            post.setThumbnail_url(thumb);
                            postService.updatePost(post);
                            session.setAttribute("toastType", "success");
                            session.setAttribute("toastTitle", "Updated!");
                            session.setAttribute("toastMessage", "Your story has been updated successfully.");
                        }
                    }
                } else if ("deletePost".equals(action)) {
                    targetSection = "manage-posts";
                    String postIdStr = req.getParameter("postId");
                    if (postIdStr != null) {
                        postService.deletePost(Long.parseLong(postIdStr));
                        session.setAttribute("toastType", "success");
                        session.setAttribute("toastTitle", "Deleted!");
                        session.setAttribute("toastMessage", "The story has been removed.");
                    }
                } else if ("approveComment".equals(action)) {
                    targetSection = "comments";
                    String commentIdStr = req.getParameter("commentId");
                    if (commentIdStr != null) {
                        commentService.approveComment(Long.parseLong(commentIdStr));
                        session.setAttribute("toastType", "success");
                        session.setAttribute("toastTitle", "Approved!");
                        session.setAttribute("toastMessage", "The comment is now visible to everyone.");
                    }
                } else if ("deleteComment".equals(action)) {
                    targetSection = "comments";
                    String commentIdStr = req.getParameter("commentId");
                    if (commentIdStr != null) {
                        commentService.deleteComment(Long.parseLong(commentIdStr));
                        session.setAttribute("toastType", "success");
                        session.setAttribute("toastTitle", "Removed!");
                        session.setAttribute("toastMessage", "The comment has been deleted.");
                    }
                } else if ("deleteUser".equals(action)) {
                    targetSection = "users";
                    String userIdStr = req.getParameter("userId");
                    if (userIdStr != null) {
                        Long userId = Long.parseLong(userIdStr);
                        // Prevent self-deletion
                        if (!user.getId().equals(userId)) {
                            userService.deleteUser(userId);
                            session.setAttribute("toastType", "success");
                            session.setAttribute("toastTitle", "User Disabled!");
                            session.setAttribute("toastMessage", "The user account and their content have been removed.");
                        }
                    }
                }
            } catch (Exception e) {
                // Log the exception if you had a logger, for now just move on
            }
            
            resp.sendRedirect("admin?section=" + targetSection);
        } else {
            resp.sendRedirect("auth");
        }
    }
}
