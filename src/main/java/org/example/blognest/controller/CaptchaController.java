package org.example.blognest.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.blognest.services.CaptchaService;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;

@WebServlet("/captcha")
public class CaptchaController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("image/png");
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        BufferedImage image = CaptchaService.generateCaptchaImage(req.getSession());
        ImageIO.write(image, "png", resp.getOutputStream());
    }
}
