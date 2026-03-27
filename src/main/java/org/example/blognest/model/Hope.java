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
    @Column(columnDefinition = "TEXT")
    private String content;

    private String emotion = "HOPEFUL";

    @Column(name = "secret_key")
    private String secretKey;

    private LocalDateTime timestamp;

    @Column(name = "is_public")
    private boolean isPublic;

    @Column(name = "support_count")
    private int supportCount = 0;

    @Column(name = "comfort_count")
    private int comfortCount = 0;

    @Column(name = "hug_count")
    private int hugCount = 0;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    @JoinColumn(name = "hope_id")
    private List<HopeUpdate> updates = new ArrayList<>();

    public Hope(String content, String emotion, boolean isPublic) {
        this.content = content;
        this.emotion = emotion != null ? emotion : "HOPEFUL";
        this.isPublic = isPublic;
        this.timestamp = LocalDateTime.now();
        this.secretKey = UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
