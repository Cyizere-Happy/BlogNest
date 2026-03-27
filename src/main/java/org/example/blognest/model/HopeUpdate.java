package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class HopeUpdate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Lob
    private String content;

    private LocalDateTime timestamp;

    public HopeUpdate(String content) {
        this.content = content;
        this.timestamp = LocalDateTime.now();
    }
}
