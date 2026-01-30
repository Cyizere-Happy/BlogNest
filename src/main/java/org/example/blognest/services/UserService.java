package org.example.blognest.services;

import org.example.blognest.model.User;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;

public class UserService {
    private static final SessionFactory sf = HibernateUtil.getSessionFactory();
    private static UserService instance;

    private UserService() {}

    public static UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    public User authenticate(String email, String password) {
        try (Session session = sf.openSession()) {
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
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            // Hash password
            String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            user.setPassword(hashed);
            // Default role is USER, set in Model
            session.persist(user);
            session.getTransaction().commit();
        }
    }

    public void updateUser(User user){
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            session.update(user);
            session.getTransaction().commit();
        }
    }

    public void deleteUser(int userId){
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            User u = session.get(User.class, (long) userId);
            if (u != null) {
                session.delete(u);
            }
            session.getTransaction().commit();
        }
    }

    public List<User> getAllUsers() {
        try (Session session = sf.openSession()) {
            return session.createQuery("from User", User.class).list();
        }
    }

    public User getUserById(Long id){
        try (Session session = sf.openSession()) {
            return session.get(User.class, id);
        }
    }
}
