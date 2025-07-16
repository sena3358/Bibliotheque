package model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reservation_id")
    private Long id;
    
    @Column(name = "date_reservation", nullable = false)
    private LocalDateTime dateReservation;
    
    @Column(name = "date_expiration")
    private LocalDateTime dateExpiration;
    
    @Enumerated(EnumType.STRING)
    private StatutReservation statut = StatutReservation.EN_ATTENTE;
    
    private Integer priorite;
    
    @ManyToOne
    @JoinColumn(name = "livre_id", nullable = false)
    private Livre livre;
    
    @ManyToOne
    @JoinColumn(name = "adherent_id", nullable = false)
    private Adherent adherent;
    
    // Constructeurs
    public Reservation() {}
    
    public Reservation(Livre livre, Adherent adherent) {
        this.livre = livre;
        this.adherent = adherent;
        this.dateReservation = LocalDateTime.now();
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDateTime getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDateTime dateReservation) { this.dateReservation = dateReservation; }
    
    public LocalDateTime getDateExpiration() { return dateExpiration; }
    public void setDateExpiration(LocalDateTime dateExpiration) { this.dateExpiration = dateExpiration; }
    
    public StatutReservation getStatut() { return statut; }
    public void setStatut(StatutReservation statut) { this.statut = statut; }
    
    public Integer getPriorite() { return priorite; }
    public void setPriorite(Integer priorite) { this.priorite = priorite; }
    
    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }
    
    public Adherent getAdherent() { return adherent; }
    public void setAdherent(Adherent adherent) { this.adherent = adherent; }
}
