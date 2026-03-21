package org.example.blognest.services;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class MailService {
    private static MailService instance;
    private final String host;
    private final String port;
    private final String username;
    private final String password;

    private MailService() {
        // Use environment variables or default to common dev settings
        this.host = System.getenv("SMTP_HOST") != null ? System.getenv("SMTP_HOST") : "smtp.gmail.com";
        this.port = System.getenv("SMTP_PORT") != null ? System.getenv("SMTP_PORT") : "587";
        this.username = System.getenv("SMTP_USER") != null ? System.getenv("SMTP_USER") : "happycyizere69@gmail.com";
        this.password = System.getenv("SMTP_PASS") != null ? System.getenv("SMTP_PASS") : "ijzpojwtzdigoxxz";
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
            System.err.println("Failed to send email to " + to + ": " + e.getMessage());
            // In a real app, you might want to throw an exception or log it properly
        }
    }
}
