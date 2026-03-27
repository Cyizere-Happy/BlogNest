package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class Hope {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Lob
    private String content;

    private String secretKey;
    private LocalDateTime timestamp;
    private boolean isPublic;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    @JoinColumn(name = "hope_id")
    private List<HopeUpdate> updates = new ArrayList<>();

    public Hope(String content, boolean isPublic) {
        this.content = content;
        this.isPublic = isPublic;
        this.timestamp = LocalDateTime.now();
        this.secretKey = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
