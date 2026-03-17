package org.example.blognest.services;

import org.example.blognest.model.MessageOfTheDay;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

public class QuoteService {
    private static QuoteService instance;
    private final AtomicReference<MessageOfTheDay> currentMessage = new AtomicReference<>();
    private final List<MessageOfTheDay> messageHistory = Collections.synchronizedList(new ArrayList<>());

    private QuoteService() {
        updateDailyMessage(
            "Growth Mindset", 
            "The journey of self-improvement is not a sprint, but a series of intentional steps towards becoming the best version of yourself.",
            Arrays.asList(
                "Embrace the struggle",
                "Learn from setbacks",
                "Stay consistent",
                "Focus on the process",
                "Celebrate small wins"
            )
        );
    }

    public static synchronized QuoteService getInstance() {
        if (instance == null) {
            instance = new QuoteService();
        }
        return instance;
    }

    public MessageOfTheDay getDailyMessage() {
        MessageOfTheDay msg = currentMessage.get();
        if (msg != null && msg.isExpired()) {
            // Move to history if expired and clear current
            messageHistory.add(0, msg);
            currentMessage.set(null);
            return null;
        }
        return msg;
    }

    public void clearDailyMessage() {
        MessageOfTheDay msg = currentMessage.get();
        if (msg != null) {
            messageHistory.add(0, msg);
            currentMessage.set(null);
        }
    }

    public void updateDailyMessage(String title, String mainMessage, List<String> takeaways) {
        MessageOfTheDay oldMessage = currentMessage.get();
        MessageOfTheDay newMessage = new MessageOfTheDay(title, mainMessage, takeaways, LocalDateTime.now());
        
        currentMessage.set(newMessage);
        
        // If there was an old message from a different day, move it to history
        if (oldMessage != null && !oldMessage.getTimestamp().toLocalDate().equals(newMessage.getTimestamp().toLocalDate())) {
            messageHistory.add(0, oldMessage);
        }
    }

    public List<MessageOfTheDay> getMessageHistory() {
        return new ArrayList<>(messageHistory);
    }
}
