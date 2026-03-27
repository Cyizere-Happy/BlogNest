package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class MessageOfTheDay {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    
    @Lob
    private String mainMessage;

    @ElementCollection(fetch = FetchType.EAGER)
    private List<String> takeaways;

    private LocalDateTime timestamp;
    private int likes = 0;

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
    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }
    
    public boolean isExpired() {
        if (timestamp == null) return true;
        return !timestamp.toLocalDate().equals(LocalDateTime.now().toLocalDate());
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
