package org.example.blognest.services;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class ChatCleanupService {
    private static final ScheduledExecutorService scheduler = Executors.newSingleThreadScheduledExecutor();

    public static void start() {
        scheduler.scheduleAtFixedRate(() -> {
            System.out.println("Starting automated chat cleanup...");
            ChatHistoryService.getInstance().deleteOldMessages(30);
        }, 0, 24, TimeUnit.HOURS);
        
        System.out.println("Chat Cleanup Service initialized (Retention: 30 days)");
    }

    public static void stop() {
        scheduler.shutdown();
    }
}
