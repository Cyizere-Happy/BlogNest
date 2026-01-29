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
            //POSTGRESQL

            settings.put(Environment.DRIVER, "org.postgresql.Driver");
//            settings.put(Environment.DRIVER, "com.mysql.cj.jdbc.Driver");
            //Postgresql
            settings.put(Environment.URL, "jdbc:postgresql://localhost:5432/hibernating");
//            settings.put(Environment.URL, "jdbc:mysql://localhost:3306/hibernating");
            settings.put(Environment.USER, "postgres");
            settings.put(Environment.PASS, "5Tr@wberry");
            //PostgreSQL
            settings.put(Environment.DIALECT, "org.hibernate.dialect.PostgreSQLDialect");
//            settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQL8Dialect");
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
