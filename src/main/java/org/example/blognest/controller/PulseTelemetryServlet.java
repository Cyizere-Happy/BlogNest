package org.example.blognest.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.blognest.services.PulseService;

import java.io.IOException;

@WebServlet("/pulse_telemetry")
public class PulseTelemetryServlet extends HttpServlet {

    private final PulseService pulseService = PulseService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String postIdStr = req.getParameter("postId");
        String sectionIndexStr = req.getParameter("sectionIndex");

        if (postIdStr != null && sectionIndexStr != null) {
            try {
                Long postId = Long.parseLong(postIdStr);
                int sectionIndex = Integer.parseInt(sectionIndexStr);
                pulseService.recordAttention(postId, sectionIndex);
                resp.setStatus(HttpServletResponse.SC_OK);
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
