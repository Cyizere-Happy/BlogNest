package org.example.blognest.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "reading_pulses")
@Getter
@Setter
@NoArgsConstructor
public class ReadingPulse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "post_id", nullable = false)
    @com.fasterxml.jackson.annotation.JsonIgnore
    private Post post;

    @Column(nullable = false)
    private int sectionIndex; // Index of the paragraph/section

    @Column(nullable = false)
    private long attentionScore; // Simulated "attention" units

    public ReadingPulse(Post post, int sectionIndex) {
        this.post = post;
        this.sectionIndex = sectionIndex;
        this.attentionScore = 0;
    }
}
