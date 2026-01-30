package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    private String description; // Summary

    @Lob
    @Column(nullable = false)
    private String content;

    private String thumbnail_url;

    private String category;

    @Column(columnDefinition = "integer default 0")
    private int views;

    private LocalDateTime createdAt;

    //  Many posts → one user
    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author;

    //  One post → many comments
    @OneToMany(mappedBy = "post", cascade = CascadeType.ALL)
    private List<Comment> comments;

    @PrePersist
    public void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Post(String title, String content, User author) {
        this.title = title;
        this.content = content;
        this.author = author;
    }

    public Post(String title, String description, String content, String category, User author) {
        this.title = title;
        this.description = description;
        this.content = content;
        this.category = category;
        this.author = author;
    }
}
