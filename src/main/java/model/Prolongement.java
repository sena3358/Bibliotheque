package model;  

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "prolongement")
public class Prolongement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "prolongement_id")
    private Long id;
    
    @Column(name = "date_demande", nullable = false)
    private LocalDateTime dateDemande;
    
    @Column(name = "date_approbation")
    private LocalDateTime dateApprobation;
    
    @Column(name = "nouvelle_date_retour")
    private LocalDate nouvelleDateRetour;
    
    
    @Enumerated(EnumType.STRING)
    private StatutProlongement statut = StatutProlongement.demande;
    
    @ManyToOne
    @JoinColumn(name = "pret_id", nullable = false)
    private Pret pret;
    
    // Constructeurs
    public Prolongement() {}
    
    public Prolongement(LocalDateTime dateDemande, LocalDateTime dateApprobation, LocalDate nouvelleDateRetour, Pret pret) {
        this.dateDemande = dateDemande;
        this.dateApprobation = dateApprobation;
        this.nouvelleDateRetour = nouvelleDateRetour;
        this.pret = pret;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDateTime getDateDemande() { return dateDemande; }
    public void setDateDemande(LocalDateTime dateDemande) { this.dateDemande = dateDemande; }
    
    public LocalDateTime getDateApprobation() { return dateApprobation; }
    public void setDateApprobation(LocalDateTime dateApprobation) { this.dateApprobation = dateApprobation; }
    
    public LocalDate getNouvelleDateRetour() { return nouvelleDateRetour; }
    public void setNouvelleDateRetour(LocalDate nouvelleDateRetour) { this.nouvelleDateRetour = nouvelleDateRetour; }
    
    public StatutProlongement getStatut() { return statut; }
    public void setStatut(StatutProlongement statut) { this.statut = statut; }
    
    public Pret getPret() { return pret; }
    public void setPret(Pret pret) { this.pret = pret; }
}
