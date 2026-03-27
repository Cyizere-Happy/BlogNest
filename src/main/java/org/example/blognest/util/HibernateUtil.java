package org.example.blognest.util;

import org.example.blognest.model.Category;
import org.example.blognest.model.Comment;
import org.example.blognest.model.Post;
import org.example.blognest.model.Subscription;
import org.example.blognest.model.User;
import org.example.blognest.services.ConfigService;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import java.util.Properties;

public class HibernateUtil {
    private static SessionFactory sessionFactory;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            Configuration configuration = new Configuration();
            Properties settings = new Properties();

            String dbUrl = ConfigService.get("DB_URL", "jdbc:postgresql://localhost:5432/hibernating");
            String dbUser = ConfigService.get("DB_USER", "postgres");
            String dbPass = ConfigService.get("DB_PASS", "5Tr@wbery");

            settings.put(Environment.DRIVER, "org.postgresql.Driver");
            settings.put(Environment.URL, dbUrl);
            settings.put(Environment.USER, dbUser);
            settings.put(Environment.PASS, dbPass);
            settings.put(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
            settings.put(Environment.SHOW_SQL, true);
            settings.put(Environment.HBM2DDL_AUTO, "update");

            configuration.setProperties(settings);

            configuration.addAnnotatedClass(Post.class);
            configuration.addAnnotatedClass(Category.class);
            configuration.addAnnotatedClass(Comment.class);
            configuration.addAnnotatedClass(User.class);
            configuration.addAnnotatedClass(Subscription.class);
            configuration.addAnnotatedClass(org.example.blognest.model.ChatHistory.class);
            configuration.addAnnotatedClass(org.example.blognest.model.MessageOfTheDay.class);
            configuration.addAnnotatedClass(org.example.blognest.model.ReadingPulse.class);
            configuration.addAnnotatedClass(org.example.blognest.model.Hope.class);
            configuration.addAnnotatedClass(org.example.blognest.model.HopeUpdate.class);

            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties()).build();
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
            
            // Self-healing: Force missing 2FA columns if Hibernate update fails
            try (org.hibernate.Session session = sessionFactory.openSession()) {
                session.beginTransaction();
                session.createNativeQuery("ALTER TABLE users ADD COLUMN IF NOT EXISTS two_factor_secret VARCHAR(255)").executeUpdate();
                session.createNativeQuery("ALTER TABLE users ADD COLUMN IF NOT EXISTS is_two_factor_enabled BOOLEAN DEFAULT FALSE").executeUpdate();
                session.createNativeQuery("ALTER TABLE messageoftheday ADD COLUMN IF NOT EXISTS likes INTEGER DEFAULT 0").executeUpdate();
                session.getTransaction().commit();
            } catch (Exception e) {
                // Silently skip if columns already exist or other DB issues
                System.err.println("Database self-healing notice: " + e.getMessage());
            }
        }
        return sessionFactory;
    }
}
