package org.example.blognest.services;

import org.example.blognest.model.Post;
import org.example.blognest.model.ReadingPulse;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class PulseService {
    private static PulseService instance;

    private PulseService() {}

    public static PulseService getInstance() {
        if (instance == null) {
            instance = new PulseService();
        }
        return instance;
    }

    public void recordAttention(Long postId, int sectionIndex) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            Query<ReadingPulse> query = session.createQuery(
                    "FROM ReadingPulse rp WHERE rp.post.id = :postId AND rp.sectionIndex = :sectionIndex", ReadingPulse.class);
            query.setParameter("postId", postId);
            query.setParameter("sectionIndex", sectionIndex);

            ReadingPulse pulse = query.uniqueResult();
            if (pulse == null) {
                Post post = session.get(Post.class, postId);
                if (post != null) {
                    pulse = new ReadingPulse(post, sectionIndex);
                    pulse.setAttentionScore(1L);
                    session.save(pulse);
                    System.out.println("[PulseService] Created new pulse for post " + postId + ", section " + sectionIndex);
                } else {
                    System.err.println("[PulseService] Post not found: " + postId);
                }
            } else {
                pulse.setAttentionScore(pulse.getAttentionScore() + 1);
                session.update(pulse);
                System.out.println("[PulseService] Updated pulse for post " + postId + ", section " + sectionIndex + ". New score: " + pulse.getAttentionScore());
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public List<ReadingPulse> getPulseData(Long postId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<ReadingPulse> query = session.createQuery(
                    "FROM ReadingPulse WHERE post.id = :postId ORDER BY sectionIndex ASC", ReadingPulse.class);
            query.setParameter("postId", postId);
            return query.list();
        }
    }
}
