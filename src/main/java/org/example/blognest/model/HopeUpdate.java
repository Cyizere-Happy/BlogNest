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

    @Column(name = "testimony", columnDefinition = "TEXT")
    private String testimony;

    private LocalDateTime timestamp;

    public HopeUpdate(String testimony) {
        this.testimony = testimony;
        this.timestamp = LocalDateTime.now();
    }
}
