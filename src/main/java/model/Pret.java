package model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "pret")
public class Pret {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "pret_id")
    private Long id;
    
    @Column(name = "date_pret", nullable = false)
    private LocalDate datePret;
    
    @Column(name = "date_retour_prevue", nullable = false)
    private LocalDate dateRetourPrevue;
    
    @Column(name = "date_retour_effective")
    private LocalDate dateRetourEffective;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "type_pret", nullable = false)
    private TypePret typePret;
    
    @Enumerated(EnumType.STRING)
    private StatutPret statut = StatutPret.en_cours;
    
    @ManyToOne
    @JoinColumn(name = "exemplaire_id", nullable = false)
    private Exemplaire exemplaire;
    
    @ManyToOne
    @JoinColumn(name = "adherent_id", nullable = false)
    private Adherent adherent;
    
    @OneToMany(mappedBy = "pret", cascade = CascadeType.ALL)
    private List<Prolongement> prolongements;
    
    @OneToMany(mappedBy = "pret", cascade = CascadeType.ALL)
    private List<Penalite> penalites;
    
    // Constructeurs
    public Pret() {}
    
    public Pret(Exemplaire exemplaire, Adherent adherent, LocalDate datePret, LocalDate dateRetourPrevue, TypePret typePret) {
        this.exemplaire = exemplaire;
        this.adherent = adherent;
        this.datePret = datePret;
        this.dateRetourPrevue = dateRetourPrevue;
        this.typePret = typePret;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDate getDatePret() { return datePret; }
    public void setDatePret(LocalDate datePret) { this.datePret = datePret; }
    
    public LocalDate getDateRetourPrevue() { return dateRetourPrevue; }
    public void setDateRetourPrevue(LocalDate dateRetourPrevue) { this.dateRetourPrevue = dateRetourPrevue; }
    
    public LocalDate getDateRetourEffective() { return dateRetourEffective; }
    public void setDateRetourEffective(LocalDate dateRetourEffective) { this.dateRetourEffective = dateRetourEffective; }
    
    public TypePret getTypePret() { return typePret; }
    public void setTypePret(TypePret typePret) { this.typePret = typePret; }
    
    public StatutPret getStatut() { return statut; }
    public void setStatut(StatutPret statut) { this.statut = statut; }
    
    public Exemplaire getExemplaire() { return exemplaire; }
    public void setExemplaire(Exemplaire exemplaire) { this.exemplaire = exemplaire; }
    
    public Adherent getAdherent() { return adherent; }
    public void setAdherent(Adherent adherent) { this.adherent = adherent; }
    
    public List<Prolongement> getProlongements() { return prolongements; }
    public void setProlongements(List<Prolongement> prolongements) { this.prolongements = prolongements; }
    
    public List<Penalite> getPenalites() { return penalites; }
    public void setPenalites(List<Penalite> penalites) { this.penalites = penalites; }
}