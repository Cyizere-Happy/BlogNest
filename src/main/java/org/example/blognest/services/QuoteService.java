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
        return currentMessage.get(); 
    }

    public void updateDailyMessage(String title, String mainMessage, List<String> takeaways) {
        MessageOfTheDay newMessage = new MessageOfTheDay(title, mainMessage, takeaways, LocalDateTime.now());
        MessageOfTheDay oldMessage = currentMessage.get();
        currentMessage.set(newMessage);
        
        if (oldMessage == null || !oldMessage.getTitle().equals(title) || !oldMessage.getMainMessage().equals(mainMessage)) {
            messageHistory.add(0, newMessage);
        }
    }

    public List<MessageOfTheDay> getMessageHistory() {
        return new ArrayList<>(messageHistory);
    }
}
