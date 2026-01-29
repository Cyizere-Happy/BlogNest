package org.example.blognest.services;

import org.example.blognest.model.Post;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.List;

public class PostService {
    public static final SessionFactory sf = HibernateUtil.getSessionFactory();
    public static PostService instance;

    public static PostService getInstance() {
        if (instance == null) {
            instance = new PostService();
        }
        return instance;
    }
    private PostService() {}

    public void addPost(Post post) {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            session.save(post);
            session.getTransaction().commit();
        }
    }

    public void updatePost(Post post) {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            session.update(post);
            session.getTransaction().commit();
        }
    }

    public void deletePost(int postId) {
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            Post p = session.get(Post.class, postId);
            if (p != null) {
                session.delete(p);
            }
            session.getTransaction().commit();
        }
    }

    public List<Post> getAllPosts() {
        try(Session session = sf.openSession()) {
            return session.createQuery("from Post").list();
        }
    }

    public Post getPostById(int postId) {
        try (Session session = sf.openSession()) {
            return session.get(Post.class, postId);
        }
    }
}
