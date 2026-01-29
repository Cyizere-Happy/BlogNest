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

}
