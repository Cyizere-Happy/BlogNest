package org.example.blognest.services;

import jakarta.activation.DataHandler;
import jakarta.activation.FileDataSource;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import java.io.File;
import java.util.Properties;

public class MailService {
    private static MailService instance;
    private final String host;
    private final String port;
    private final String username;
    private final String password;

    private MailService() {
        this.host = ConfigService.get("SMTP_HOST", "smtp.gmail.com");
        this.port = ConfigService.get("SMTP_PORT", "587");
        this.username = ConfigService.get("SMTP_USER");
        this.password = ConfigService.get("SMTP_PASS");
    }

    public static synchronized MailService getInstance() {
        if (instance == null) {
            instance = new MailService();
        }
        return instance;
    }

    public void sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(content);

            Transport.send(message);
            System.out.println("Email sent successfully to " + to);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void sendVerificationEmail(String to, String code, String mascotPath) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, "BlogNest"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Verify your BlogNest Account");

            // Create the HTML content
            String htmlContent = "<div style=\"font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e2e8f0; border-radius: 12px; background-color: #ffffff;\">" +
                    "  <div style=\"text-align: center; margin-bottom: 25px;\">" +
                    "    <img src=\"cid:mascot\" alt=\"BlogNest Mascot\" style=\"width: 100px; height: auto; margin-bottom: 10px;\">" +
                    "    <h1 style=\"color: #1e293b; margin: 0; font-size: 28px;\">Blog<span style=\"color: #3b82f6;\">Nest</span></h1>" +
                    "  </div>" +
                    "  <div style=\"color: #475569; line-height: 1.6;\">" +
                    "    <p style=\"font-size: 18px; text-align: center; font-weight: 500;\">Hello there!</p>" +
                    "    <p style=\"text-align: center;\">Thank you for joining our community. To finalize your registration, please use the following verification code:</p>" +
                    "    <div style=\"background-color: #f8fafc; border: 2px dashed #cbd5e1; border-radius: 8px; padding: 20px; text-align: center; margin: 30px 0;\">" +
                    "      <span style=\"font-size: 36px; font-weight: 700; color: #0f172a; letter-spacing: 5px;\">" + code + "</span>" +
                    "    </div>" +
                    "    <p style=\"text-align: center; font-size: 14px; color: #64748b;\">This code will expire in <strong>5 minutes</strong>.</p>" +
                    "  </div>" +
                    "  <div style=\"margin-top: 30px; padding-top: 20px; border-top: 1px solid #f1f5f9; text-align: center; color: #94a3b8; font-size: 12px;\">" +
                    "    &copy; 2024 BlogNest. All rights reserved." +
                    "  </div>" +
                    "</div>";

            // Create multipart content
            MimeMultipart multipart = new MimeMultipart("related");

            // First part (HTML)
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(htmlContent, "text/html; charset=utf-8");
            multipart.addBodyPart(messageBodyPart);

            // Second part (the image)
            if (mascotPath != null && new File(mascotPath).exists()) {
                messageBodyPart = new MimeBodyPart();
                FileDataSource fds = new FileDataSource(mascotPath);
                messageBodyPart.setDataHandler(new DataHandler(fds));
                messageBodyPart.setHeader("Content-ID", "<mascot>");
                multipart.addBodyPart(messageBodyPart);
            }

            message.setContent(multipart);
            Transport.send(message);
            System.out.println("Enhanced verification email sent correctly to " + to);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
