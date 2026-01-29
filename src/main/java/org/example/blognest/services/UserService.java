package org.example.blognest.services;

import org.example.blognest.model.User;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

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

    public void addUser(User user){
        try (Session session = sf.openSession()) {
            session.beginTransaction();
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

    public void deleteUser(User user){
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            User u = session.get(User.class, user.getId());
            if (u != null) {
                session.delete(u);
            }
            session.getTransaction().commit();
        }
    }

    public List<User> getAllUsers() {
        try (Session session = sf.openSession()) {
            return session.createQuery("from User").list();
        }
    }

    public User getUserById(int id){
        try (Session session = sf.openSession()) {
            return session.get(User.class, id);
        }
    }

}
