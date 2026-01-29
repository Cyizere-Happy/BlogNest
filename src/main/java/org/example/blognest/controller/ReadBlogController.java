package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

@WebServlet("/ReadBlog")
public class ReadBlogController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check file path (optional debug)
        System.out.println("Forwarding to: " + getServletContext().getRealPath("/WEB-INF/read_blog.jsp"));

        // Forward request to JSP inside WEB-INF
        request.getRequestDispatcher("/WEB-INF/read_blog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}