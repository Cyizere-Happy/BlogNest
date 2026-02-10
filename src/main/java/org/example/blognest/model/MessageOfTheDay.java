package org.example.blognest.model;

import java.util.List;

public class MessageOfTheDay {
    private String title;
    private String mainMessage;
    private List<String> takeaways;
    private int day;

    public MessageOfTheDay(String title, String mainMessage, List<String> takeaways, int day) {
        this.title = title;
        this.mainMessage = mainMessage;
        this.takeaways = takeaways;
        this.day = day;
    }

    public String getTitle() { return title; }
    public String getMainMessage() { return mainMessage; }
    public List<String> getTakeaways() { return takeaways; }
    public int getDay() { return day; }
    
    public String getFormattedDay() {
        return String.format("%02d", day);
    }
}
