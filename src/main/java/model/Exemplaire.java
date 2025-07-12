package model;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "exemplaire")
public class Exemplaire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "exemplaire_id")
    private Long id;
    
    @Column(name = "code_barre", unique = true)
    private String codeBarre;
    
    @Enumerated(EnumType.STRING)
    private StatutExemplaire statut = StatutExemplaire.disponible;
    
    @Column(name = "date_ajout")
    private LocalDate dateAjout;
    
    private String emplacement;
    
    @ManyToOne
    @JoinColumn(name = "livre_id", nullable = false)
    private Livre livre;
    
    @OneToMany(mappedBy = "exemplaire", cascade = CascadeType.ALL)
    private List<Pret> prets;
    
    // Constructeurs
    public Exemplaire() {}
    
    public Exemplaire(String codeBarre, Livre livre) {
        this.codeBarre = codeBarre;
        this.livre = livre;
        this.dateAjout = LocalDate.now();
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getCodeBarre() { return codeBarre; }
    public void setCodeBarre(String codeBarre) { this.codeBarre = codeBarre; }
    
    public StatutExemplaire getStatut() { return statut; }
    public void setStatut(StatutExemplaire statut) { this.statut = statut; }
    
    public LocalDate getDateAjout() { return dateAjout; }
    public void setDateAjout(LocalDate dateAjout) { this.dateAjout = dateAjout; }
    
    public String getEmplacement() { return emplacement; }
    public void setEmplacement(String emplacement) { this.emplacement = emplacement; }
    
    public Livre getLivre() { return livre; }
    public void setLivre(Livre livre) { this.livre = livre; }
    
    public List<Pret> getPrets() { return prets; }
    public void setPrets(List<Pret> prets) { this.prets = prets; }

    public void setStatut(Object statut2) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'setStatut'");
    }
}
