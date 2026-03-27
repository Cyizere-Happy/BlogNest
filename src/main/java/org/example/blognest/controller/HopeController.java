package org.example.blognest.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.blognest.model.Hope;
import org.example.blognest.services.HopeService;
import org.example.blognest.util.InputSanitizer;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/hope", "/hope/journey"})
public class HopeController extends HttpServlet {
    private final HopeService hopeService = HopeService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        
        if ("/hope/journey".equals(path)) {
            handleJourney(req, resp);
            return;
        }

        int limit = 10;
        String limitStr = req.getParameter("limit");
        if (limitStr != null) {
            try { limit = Integer.parseInt(limitStr); } catch (Exception ignored) {}
        }

        List<Hope> publicHopes = hopeService.getPublicHopes(limit);
        req.setAttribute("publicHopes", publicHopes);
        req.setAttribute("currentLimit", limit);
        req.getRequestDispatcher("/WEB-INF/HopeJournal.jsp").forward(req, resp);
    }

    private void handleJourney(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String key = req.getParameter("key");
        if (key != null) {
            Hope hope = hopeService.getHopeBySecretKey(key);
            if (hope != null) {
                req.setAttribute("myHope", hope);
                req.getRequestDispatcher("/WEB-INF/HopeJourney.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/hope?error=Seal unbroken. Key invalid.");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        if ("release".equals(action)) {
            String content = InputSanitizer.sanitizeRich(req.getParameter("content"));
            String emotion = req.getParameter("emotion");
            boolean isPublic = req.getParameter("isPublic") != null;

            if (content != null && !content.isEmpty()) {
                Hope hope = hopeService.createHope(content, emotion, isPublic);
                if (hope != null) {
                    session.setAttribute("newHopeKey", hope.getSecretKey());
                    session.setAttribute("toastType", "success");
                    session.setAttribute("toastTitle", "Hope Sealed");
                    session.setAttribute("toastMessage", "Your moment has been preserved.");
                }
            }
            resp.sendRedirect(req.getContextPath() + "/hope");
        } else if ("react".equals(action)) {
            String idStr = req.getParameter("id");
            String type = req.getParameter("type");
            if (idStr != null && type != null) {
                hopeService.react(Long.parseLong(idStr), type);
            }
            String referer = req.getHeader("Referer");
            resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/hope");
        } else if ("evolve".equals(action)) {
            String hopeIdStr = req.getParameter("hopeId");
            String updateContent = InputSanitizer.sanitizeRich(req.getParameter("updateContent"));
            String key = req.getParameter("revisitKey");

            if (hopeIdStr != null && updateContent != null && !updateContent.isEmpty()) {
                hopeService.addUpdate(Long.parseLong(hopeIdStr), updateContent);
                session.setAttribute("toastType", "success");
                session.setAttribute("toastTitle", "Evolved");
                session.setAttribute("toastMessage", "Your story continues.");
                resp.sendRedirect(req.getContextPath() + "/hope/journey?key=" + key);
                return;
            }
        }
    }
}
