package org.example.blognest.services;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigService {
    private static final Properties properties = new Properties();

    static {
        // Loads .env (as a property file) from the classpath (src/main/resources)
        try (InputStream input = ConfigService.class.getClassLoader().getResourceAsStream(".env")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (IOException ex) {
            // Error handling without printing to console
        }
    }

    public static String get(String key) {
        // Prioritize actual system environment variables (for deployment)
        String value = System.getenv(key);
        if (value != null) return value;
        return properties.getProperty(key);
    }

    public static String get(String key, String defaultValue) {
        String value = get(key);
        return (value != null) ? value : defaultValue;
    }
}
