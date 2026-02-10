package org.example.blognest.services;

import org.example.blognest.model.MessageOfTheDay;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

public class QuoteService {
    private static QuoteService instance;
    private final AtomicReference<MessageOfTheDay> currentMessage = new AtomicReference<>();
    private final List<MessageOfTheDay> messageHistory = Collections.synchronizedList(new ArrayList<>());

    private QuoteService() {
        // Initialize with default content
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
        int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        MessageOfTheDay msg = currentMessage.get();
        // Return current message with today's date if title matches, otherwise keep msg as is
        return new MessageOfTheDay(msg.getTitle(), msg.getMainMessage(), msg.getTakeaways(), day);
    }

    public void updateDailyMessage(String title, String mainMessage, List<String> takeaways) {
        int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        MessageOfTheDay newMessage = new MessageOfTheDay(title, mainMessage, takeaways, day);
        currentMessage.set(newMessage);
        messageHistory.add(0, newMessage); // Add to the beginning of history
    }

    public List<MessageOfTheDay> getMessageHistory() {
        return new ArrayList<>(messageHistory);
    }
}
