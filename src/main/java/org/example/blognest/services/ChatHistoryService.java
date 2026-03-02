package org.example.blognest.services;

import org.example.blognest.model.ChatHistory;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.util.List;

public class ChatHistoryService {
    private ChatHistoryService() {}

    private static class Holder {
        private static final ChatHistoryService INSTANCE = new ChatHistoryService();
    }

    public static ChatHistoryService getInstance() {
        return Holder.INSTANCE;
    }

    private SessionFactory getSf() {
        return HibernateUtil.getSessionFactory();
    }

    public void saveMessage(ChatHistory history) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            session.persist(history);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<ChatHistory> getHistory(String user1, String user2) {
        try (Session session = getSf().openSession()) {
            return session.createQuery(
                "FROM ChatHistory WHERE (sender = :u1 AND recipient = :u2) OR (sender = :u2 AND recipient = :u1) ORDER BY timestamp ASC", 
                ChatHistory.class)
                .setParameter("u1", user1)
                .setParameter("u2", user2)
                .list();
        } catch (Exception e) {
            System.err.println("Error fetching chat history: " + e.getMessage());
            e.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }
}
