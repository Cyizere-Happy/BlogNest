package org.example.blognest.services;

import org.example.blognest.model.Comment;
import org.example.blognest.model.Post;
import org.example.blognest.model.User;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.util.List;
public class PostService {
    private PostService() {}

    private static class Holder {
        private static final PostService INSTANCE = new PostService();
    }

    public static PostService getInstance() {
        return Holder.INSTANCE;
    }

    private SessionFactory getSf() {
        return HibernateUtil.getSessionFactory();
    }

    public void createPost(Post post) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            session.persist(post);
            session.getTransaction().commit();
        }
    }

    public List<Post> getAllPosts() {
        try (Session session = getSf().openSession()) {
            return session.createQuery("FROM Post ORDER BY createdAt DESC", Post.class).list();
        }
    }

    public Post getPostById(Long id) {
        try (Session session = getSf().openSession()) {
            Post post = session.get(Post.class, id);
            if (post != null) {
                // Initialize comments to prevent LazyInitializationException
                Hibernate.initialize(post.getComments());
            }
            return post;
        }
    }

    public void addComment(Long postId, Long userId, String content) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            Post post = session.get(Post.class, postId);
            User user = session.get(User.class, userId);
            
            if (post != null && user != null) {
                Comment comment = new Comment(content, user, post);
                session.persist(comment);
            }
            session.getTransaction().commit();
        }
    }
    
    public void deletePost(Long id) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            Post post = session.get(Post.class, id);
            if (post != null) {
                session.remove(post);
            }
            session.getTransaction().commit();
        }
    }

    public void updatePost(Post post) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            session.merge(post);
            session.getTransaction().commit();
        }
    }

    public void incrementViews(Long postId) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            Post post = session.get(Post.class, postId);
            if (post != null) {
                post.setViews(post.getViews() + 1);
            }
            session.getTransaction().commit();
        }
    }
}
