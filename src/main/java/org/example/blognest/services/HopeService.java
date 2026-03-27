package org.example.blognest.services;

import org.example.blognest.model.Hope;
import org.example.blognest.model.HopeUpdate;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.List;

public class HopeService {
    private static HopeService instance;

    private HopeService() {}

    public static synchronized HopeService getInstance() {
        if (instance == null) {
            instance = new HopeService();
        }
        return instance;
    }

    public String createHope(String content, boolean isPublic) {
        Hope hope = new Hope(content, isPublic);
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(hope);
            tx.commit();
            return hope.getSecretKey();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Hope getHopeBySecretKey(String key) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Hope> query = session.createQuery("from Hope where secretKey = :key", Hope.class);
            query.setParameter("key", key.toUpperCase());
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Hope> getPublicHopes(int limit) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Hope> query = session.createQuery("from Hope where isPublic = true order by timestamp desc", Hope.class);
            query.setMaxResults(limit);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void addUpdate(Long hopeId, String updateContent) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Hope hope = session.get(Hope.class, hopeId);
            if (hope != null) {
                HopeUpdate update = new HopeUpdate(updateContent);
                hope.getUpdates().add(update);
                session.merge(hope);
            }
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
