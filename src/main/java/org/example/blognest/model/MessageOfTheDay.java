package org.example.blognest.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class MessageOfTheDay {
    private String title;
    private String mainMessage;
    private List<String> takeaways;
    private LocalDateTime timestamp;

    public MessageOfTheDay(String title, String mainMessage, List<String> takeaways, LocalDateTime timestamp) {
        this.title = title;
        this.mainMessage = mainMessage;
        this.takeaways = takeaways;
        this.timestamp = timestamp;
    }

    public String getTitle() { return title; }
    public String getMainMessage() { return mainMessage; }
    public List<String> getTakeaways() { return takeaways; }
    public LocalDateTime getTimestamp() { return timestamp; }
    
    public boolean isExpired() {
        return timestamp == null || timestamp.isBefore(LocalDateTime.now().minusDays(7));
    }

    public String getFormattedDay() {
        return timestamp != null ? timestamp.format(DateTimeFormatter.ofPattern("dd")) : "--";
    }

    public String getRelativeTime() {
        if (timestamp == null) return "Unknown";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        return timestamp.format(formatter);
    }
}
