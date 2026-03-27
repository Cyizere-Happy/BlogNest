package org.example.blognest.services;

import org.example.blognest.model.MessageOfTheDay;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class QuoteService {
    private static QuoteService instance;

    private QuoteService() {}

    public static synchronized QuoteService getInstance() {
        if (instance == null) {
            instance = new QuoteService();
        }
        return instance;
    }

    public MessageOfTheDay getDailyMessage() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // Get the latest message
            Query<MessageOfTheDay> query = session.createQuery("from MessageOfTheDay order by timestamp desc", MessageOfTheDay.class);
            query.setMaxResults(1);
            MessageOfTheDay msg = query.uniqueResult();
            
            if (msg != null && msg.isExpired()) {
                // Return null if expired; the system will show "No message"
                return null;
            }
            return msg;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void clearDailyMessage() {
        // Technically, with next-day expiration, "clearing" just means 
        // there is no current message. We could set the timestamp to 
        // slightly older or just let getDailyMessage return null if we 
        // deleted the current one. 
        // For simplicity, let's just make it expired by setting timestamp to yesterday.
        MessageOfTheDay msg = getDailyMessage();
        if (msg != null) {
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                Transaction transaction = session.beginTransaction();
                msg.setTimestamp(LocalDateTime.now().minusDays(1));
                session.merge(msg);
                transaction.commit();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void updateDailyMessage(String title, String mainMessage, List<String> takeaways) {
        MessageOfTheDay newMessage = new MessageOfTheDay(title, mainMessage, takeaways, LocalDateTime.now());
        
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.persist(newMessage);
            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update daily message", e);
        }
    }

    public List<MessageOfTheDay> getMessageHistory() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<MessageOfTheDay> query = session.createQuery("from MessageOfTheDay order by timestamp desc", MessageOfTheDay.class);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int likeMessage(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            MessageOfTheDay msg = session.get(MessageOfTheDay.class, id);
            int newLikes = 0;
            if (msg != null) {
                newLikes = msg.getLikes() + 1;
                msg.setLikes(newLikes);
                session.merge(msg);
            }
            transaction.commit();
            return newLikes;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
