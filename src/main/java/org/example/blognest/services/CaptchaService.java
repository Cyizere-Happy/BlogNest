package org.example.blognest.services;

import jakarta.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

public class CaptchaService {
    private static final int WIDTH = 120;
    private static final int HEIGHT = 40;
    private static final String CAPTCHA_SESSION_KEY = "CAPTCHA_ANSWER";

    public static BufferedImage generateCaptchaImage(HttpSession session) {
        String captchaText = generateRandomString(6);
        session.setAttribute(CAPTCHA_SESSION_KEY, captchaText);

        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = image.createGraphics();

        // Background
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, WIDTH, HEIGHT);

        // Noise
        Random random = new Random();
        g2d.setColor(new Color(220, 220, 220));
        for (int i = 0; i < 50; i++) {
            int x = random.nextInt(WIDTH);
            int y = random.nextInt(HEIGHT);
            g2d.drawRect(x, y, 1, 1);
        }

        // Text
        g2d.setFont(new Font("Georgia", Font.BOLD, 22));
        for (int i = 0; i < captchaText.length(); i++) {
            g2d.setColor(new Color(random.nextInt(100), random.nextInt(100), random.nextInt(100)));
            g2d.drawString(String.valueOf(captchaText.charAt(i)), 10 + (i * 18), 28);
        }

        g2d.dispose();
        return image;
    }

    public static boolean verifyCaptcha(HttpSession session, String answer) {
        String expected = (String) session.getAttribute(CAPTCHA_SESSION_KEY);
        if (expected == null || answer == null) return false;
        return expected.equalsIgnoreCase(answer.trim());
    }

    private static String generateRandomString(int length) {
        String chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"; // Removed ambiguous chars like 0, O, 1, I, L
        StringBuilder sb = new StringBuilder();
        Random rnd = new Random();
        while (sb.length() < length) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
