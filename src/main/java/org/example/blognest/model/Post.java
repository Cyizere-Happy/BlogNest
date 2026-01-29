package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    private String description;

    @Lob
    @Column(nullable = false)
    private String content;

    private LocalDateTime createdAt;

    //  Many posts → one user
    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author;

    //  One post → many comments
    @OneToMany(mappedBy = "post")
    private List<Comment> comments;

    @PrePersist
    public void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Post() {}

    public Post(String title, String content, LocalDateTime createdAt, User author, List<Comment> comments) {
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.author = author;
        this.comments = comments;
    }

    public Post(String title, String content, LocalDateTime createdAt, User author) {
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.author = author;
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", createdAt=" + createdAt +
                ", author=" + author +
                ", comments=" + comments +
                '}';
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContent() {
        return content;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public User getAuthor() {
        return author;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }
}
