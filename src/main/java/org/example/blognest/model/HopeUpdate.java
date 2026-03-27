package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;

@Entity
@Table(name = "sanctuary_hope_update")
@Getter
@Setter
@NoArgsConstructor
public class HopeUpdate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(columnDefinition = "TEXT")
    private String content;

    private LocalDateTime timestamp;

    public HopeUpdate(String content) {
        this.content = content;
        this.timestamp = LocalDateTime.now();
    }
}
