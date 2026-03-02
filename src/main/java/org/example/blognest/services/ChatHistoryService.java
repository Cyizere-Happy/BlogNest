package org.example.blognest.services;

import org.example.blognest.model.ChatHistory;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.time.LocalDateTime;
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

    public ChatHistory getLatestMessage(String user1, String user2) {
        try (Session session = getSf().openSession()) {
            return session.createQuery(
                "FROM ChatHistory WHERE (sender = :u1 AND recipient = :u2) OR (sender = :u2 AND recipient = :u1) ORDER BY timestamp DESC", 
                ChatHistory.class)
                .setParameter("u1", user1)
                .setParameter("u2", user2)
                .setMaxResults(1)
                .uniqueResult();
        } catch (Exception e) {
            return null;
        }
    }

    public void deleteOldMessages(int days) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            LocalDateTime threshold = LocalDateTime.now().minusDays(days);
            int deleted = session.createQuery("DELETE FROM ChatHistory WHERE timestamp < :threshold")
                    .setParameter("threshold", threshold)
                    .executeUpdate();
            session.getTransaction().commit();
            System.out.println("Cleanup successful: Deleted " + deleted + " messages older than " + days + " days.");
        } catch (Exception e) {
            System.err.println("Cleanup failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
