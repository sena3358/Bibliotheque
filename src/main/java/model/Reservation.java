package model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reservation_id")
    private Long id;
    
    @Column(name = "date_reservation", nullable = false)
    private LocalDate dateReservation;
    
    @Enumerated(EnumType.STRING)
    private StatutReservation statut = StatutReservation.en_attente;
    
    @ManyToOne
    @JoinColumn(name = "exemplaire_id", nullable = false)
    private Exemplaire Exemplaire;
    
    @ManyToOne
    @JoinColumn(name = "adherent_id", nullable = false)
    private Adherent adherent;

    @ManyToOne
    @JoinColumn(name = "livre_id", nullable = false)
    private Livre livre;

    // Constructeurs
    public Reservation() {}

    public Reservation(LocalDate dateReservation, StatutReservation statut, Exemplaire Exemplaire, Adherent adherent, Livre livre) {
        this.dateReservation = dateReservation;
        this.statut = statut;
        this.Exemplaire = Exemplaire;
        this.adherent = adherent;
        this.livre = livre;
    }

    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDate getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDate dateReservation) { this.dateReservation = dateReservation; }
    
    public StatutReservation getStatut() { return statut; }
    public void setStatut(StatutReservation statut) { this.statut = statut; }
    
    public Exemplaire getExemplaire() { return Exemplaire; }
    public void setExemplaire(Exemplaire Exemplaire) { this.Exemplaire = Exemplaire; }
    
    public Adherent getAdherent() { return adherent; }
    public void setAdherent(Adherent adherent) { this.adherent = adherent; }

    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }
}
