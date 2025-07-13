package model;



import java.math.BigDecimal;
import java.time.LocalDate;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "penalite")
public class Penalite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "penalite_id")
    private Long id;
    
    @Column(name = "date_emission", nullable = false)
    private LocalDate dateEmission;
    
    @Column(name = "date_fin")
    private LocalDate dateFin;
        
    @ManyToOne
    @JoinColumn(name = "pret_id", nullable = false)
    private Pret pret;
    
    @ManyToOne
    @JoinColumn(name = "adherent_id", nullable = false)
    private Adherent adherent;
    
    

    // Constructeurs
    public Penalite() {}
    
    public Penalite(LocalDate dateEmission, LocalDate dateFin, Pret pret, Adherent adherent) {
        this.dateEmission = LocalDate.now();
        this.dateFin = dateFin;
        this.pret = pret;
        this.adherent = adherent;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDate getDateEmission() { return dateEmission; }
    public void setDateEmission(LocalDate dateEmission) { this.dateEmission = dateEmission; }
    
    public LocalDate getDateFin() { return dateFin; }
    public void setDateFin(LocalDate dateFin) { this.dateFin = dateFin; }
    
    
    public Pret getPret() { return pret; }
    public void setPret(Pret pret) { this.pret = pret; }
    
    public Adherent getAdherent() { return adherent; }
    public void setAdherent(Adherent adherent) { this.adherent = adherent; }
}