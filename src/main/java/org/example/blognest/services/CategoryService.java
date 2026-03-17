package org.example.blognest.services;

import org.example.blognest.model.Category;
import org.example.blognest.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.util.List;

public class CategoryService {
    private CategoryService() {}

    private static class Holder {
        private static final CategoryService INSTANCE = new CategoryService();
    }

    public static CategoryService getInstance() {
        return Holder.INSTANCE;
    }

    private SessionFactory getSf() {
        return HibernateUtil.getSessionFactory();
    }

    public List<Category> getAllCategories() {
        try (Session session = getSf().openSession()) {
            return session.createQuery("FROM Category ORDER BY name ASC", Category.class).list();
        }
    }

    public Category getCategoryByName(String name) {
        try (Session session = getSf().openSession()) {
            return session.createQuery("FROM Category WHERE name = :name", Category.class)
                    .setParameter("name", name)
                    .uniqueResult();
        }
    }

    public Category getOrCreateCategoryByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return null;
        }
        name = name.trim();
        Category category = getCategoryByName(name);
        if (category == null) {
            category = new Category(name);
            try (Session session = getSf().openSession()) {
                session.beginTransaction();
                session.persist(category);
                session.getTransaction().commit();
            }
        }
        return category;
    }

    public Category getCategoryById(Long id) {
        try (Session session = getSf().openSession()) {
            return session.get(Category.class, id);
        }
    }

    public void deleteCategory(Long id) {
        try (Session session = getSf().openSession()) {
            session.beginTransaction();
            Category category = session.get(Category.class, id);
            if (category != null) {
                // Note: posts using this category will have category_id set to NULL if not handled
                session.remove(category);
            }
            session.getTransaction().commit();
        }
    }
}
