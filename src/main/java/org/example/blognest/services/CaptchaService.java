package org.example.blognest.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

public class CaptchaService {
    private static final String RECAPTCHA_SECRET = ConfigService.get("RECAPTCHA_SECRET_KEY");

    public static boolean verifyReCaptcha(String responseToken) {
        if (responseToken == null || responseToken.trim().isEmpty()) {
            return false;
        }

        try {
            URL url = new URL("https://www.google.com/recaptcha/api/siteverify");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            String params = "secret=" + RECAPTCHA_SECRET + "&response=" + responseToken;
            try (OutputStream os = conn.getOutputStream()) {
                os.write(params.getBytes());
                os.flush();
            }

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                try (Scanner scanner = new Scanner(conn.getInputStream())) {
                    String jsonResponse = scanner.useDelimiter("\\A").next();
                    ObjectMapper mapper = new ObjectMapper();
                    JsonNode node = mapper.readTree(jsonResponse);
                    return node.has("success") && node.get("success").asBoolean();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
