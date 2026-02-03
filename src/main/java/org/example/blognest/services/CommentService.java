package org.example.blognest.services;

import org.example.blognest.model.Comment;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.util.List;
public class CommentService {
    private CommentService() {}

    private static class Holder {
        private static final CommentService INSTANCE = new CommentService();
    }

    public static CommentService getInstance() {
        return Holder.INSTANCE;
    }

    private SessionFactory getSf() {
        return HibernateUtil.getSessionFactory();
    }

    public List<Comment> getAllComments() {
        try (Session session = getSf().openSession()) {
            return session.createQuery("FROM Comment ORDER BY createdAt DESC", Comment.class).list();
        }
    }

    public void approveComment(Long id) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            Comment comment = session.get(Comment.class, id);
            if (comment != null) {
                comment.setApproved(true);
            }
            session.getTransaction().commit();
        }
    }

    public void deleteComment(Long id) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            Comment comment = session.get(Comment.class, id);
            if (comment != null) {
                session.remove(comment);
            }
            session.getTransaction().commit();
        }
    }
}
