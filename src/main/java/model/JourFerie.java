package model;

import java.time.LocalDate;

import org.springframework.cglib.core.Local;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "JourFerie")
public class JourFerie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "jour_ferie_id")
    private Long id;

    @Column(name = "date_ferie", nullable = false)
    private LocalDate date;


    public JourFerie() {}
    public JourFerie(LocalDate date) {
        this.date = date;
    }
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

}
