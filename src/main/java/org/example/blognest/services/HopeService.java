package org.example.blognest.services;

import org.example.blognest.model.Hope;
import org.example.blognest.model.HopeUpdate;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDateTime;
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

    public Hope createHope(String content, String emotion, boolean isPublic) {
        Hope hope = new Hope(content, emotion, isPublic);
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(hope);
            tx.commit();
            return hope;
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

    public void react(Long hopeId, String type) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Hope hope = session.get(Hope.class, hopeId);
            if (hope != null) {
                if ("support".equals(type)) hope.setSupportCount(hope.getSupportCount() + 1);
                else if ("comfort".equals(type)) hope.setComfortCount(hope.getComfortCount() + 1);
                else if ("hug".equals(type)) hope.setHugCount(hope.getHugCount() + 1);
                session.merge(hope);
            }
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
