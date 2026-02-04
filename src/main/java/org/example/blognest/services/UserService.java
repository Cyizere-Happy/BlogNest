package org.example.blognest.services;

import org.example.blognest.model.User;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;
public class UserService {
    private UserService() {}

    private static class Holder {
        private static final UserService INSTANCE = new UserService();
    }

    public static UserService getInstance() {
        return Holder.INSTANCE;
    }

    private SessionFactory getSf() {
        return HibernateUtil.getSessionFactory();
    }

    public User authenticate(String email, String password) {
        try (Session session = getSf().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            User user = query.uniqueResult();

            if (user != null && BCrypt.checkpw(password, user.getPassword())) {
                return user;
            }
            return null;
        }
    }

    public void addUser(User user){
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashed);
            session.persist(user);
            session.getTransaction().commit();
        }
    }

    public void updateUser(User user){
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            session.update(user);
            session.getTransaction().commit();
        }
    }

    public void deleteUser(Long userId){
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            User u = session.get(User.class, userId);
            if (u != null) {
                session.delete(u);
            }
            session.getTransaction().commit();
        }
    }

    public List<User> getAllUsers() {
        try (Session session = getSf().openSession()) {
            return session.createQuery("from User", User.class).list();
        }
    }

    public User getUserById(Long id){
        try (Session session = getSf().openSession()) {
            return session.get(User.class, id);
        }
    }

    public User getUserByEmail(String email) {
        try (Session session = getSf().openSession()) {
            Query<User> query = session.createQuery("FROM User WHERE email = :email", User.class);
            query.setParameter("email", email);
            return query.uniqueResult();
        }
    }
}
