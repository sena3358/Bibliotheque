package model;


import jakarta.persistence.*;

@Entity
@Table(name = "profilpret")
public class ProfilPret {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "profil_id")
    private Long id;
    
    @Column(name = "duree_pret_jours", nullable = false)
    private Integer dureePretJours;
    
    @Column(name = "nombre_max_pret", nullable = false)
    private Integer nombreMaxPret;
    
    @Column(name = "nombre_max_prolongement", nullable = false)
    private Integer nombreMaxProlongement;
    
    @Column(name = "delai_prolongement_jours", nullable = false)
    private Integer delaiProlongementJours;
    
    @Column(name = "delai_de_pret")
    private Integer delaiDePret;
    
    @Column(name = "delai_de_pret_sur_place")
    private Integer delaiDePretSurPlace;
    
    @OneToOne
    @JoinColumn(name = "type_membre_id", nullable = false, unique = true)
    private TypeMembre typeMembre;
    
    // Constructeurs
    public ProfilPret() {}
    
    public ProfilPret(TypeMembre typeMembre, Integer dureePretJours, Integer nombreMaxPret, Integer nombreMaxProlongement, Integer delaiProlongementJours) {
        this.typeMembre = typeMembre;
        this.dureePretJours = dureePretJours;
        this.nombreMaxPret = nombreMaxPret;
        this.nombreMaxProlongement = nombreMaxProlongement;
        this.delaiProlongementJours = delaiProlongementJours;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Integer getDureePretJours() { return dureePretJours; }
    public void setDureePretJours(Integer dureePretJours) { this.dureePretJours = dureePretJours; }
    
    public Integer getNombreMaxPret() { return nombreMaxPret; }
    public void setNombreMaxPret(Integer nombreMaxPret) { this.nombreMaxPret = nombreMaxPret; }
    
    public Integer getNombreMaxProlongement() { return nombreMaxProlongement; }
    public void setNombreMaxProlongement(Integer nombreMaxProlongement) { this.nombreMaxProlongement = nombreMaxProlongement; }
    
    public Integer getDelaiProlongementJours() { return delaiProlongementJours; }
    public void setDelaiProlongementJours(Integer delaiProlongementJours) { this.delaiProlongementJours = delaiProlongementJours; }
    
    public Integer getDelaiDePret() { return delaiDePret; }
    public void setDelaiDePret(Integer delaiDePret) { this.delaiDePret = delaiDePret; }
    
    public Integer getDelaiDePretSurPlace() { return delaiDePretSurPlace; }
    public void setDelaiDePretSurPlace(Integer delaiDePretSurPlace) { this.delaiDePretSurPlace = delaiDePretSurPlace; }
    
    public TypeMembre getTypeMembre() { return typeMembre; }
    public void setTypeMembre(TypeMembre typeMembre) { this.typeMembre = typeMembre; }

    public ProfilPret orElseThrow(Object object) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'orElseThrow'");
    }
}
