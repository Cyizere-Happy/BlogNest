package org.example.blognest.util;

import org.example.blognest.model.Comment;
import org.example.blognest.model.Post;
import org.example.blognest.model.Subscription;
import org.example.blognest.model.User;
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

            // Use environment variables if available (for Docker Compose)
            String dbUrl = System.getenv().getOrDefault("DB_URL", "jdbc:postgresql://localhost:5432/hibernating");
            String dbUser = System.getenv().getOrDefault("DB_USER", "postgres");
            String dbPass = System.getenv().getOrDefault("DB_PASSWORD", "5Tr@wberry");

            settings.put(Environment.DRIVER, "org.postgresql.Driver");
            settings.put(Environment.URL, dbUrl);
            settings.put(Environment.USER, dbUser);
            settings.put(Environment.PASS, dbPass);
            settings.put(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
            settings.put(Environment.SHOW_SQL, true);
            settings.put(Environment.HBM2DDL_AUTO, "update");

            configuration.setProperties(settings);

            configuration.addAnnotatedClass(Post.class);
            configuration.addAnnotatedClass(Comment.class);
            configuration.addAnnotatedClass(User.class);
            configuration.addAnnotatedClass(Subscription.class);

            ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                    .applySettings(configuration.getProperties()).build();
            sessionFactory = configuration.buildSessionFactory(serviceRegistry);
        }
        return sessionFactory;
    }
}
