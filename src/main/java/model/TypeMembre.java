package model;

import jakarta.persistence.*;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "typemembre")
public class TypeMembre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "type_membre_id")
    private Long id;
    
    @Column(unique = true, nullable = false)
    private String code;
    
    @Column(nullable = false)
    private String libelle;
    
    private String description;
    
    @JsonIgnore
    @OneToMany(mappedBy = "typeMembre", cascade = CascadeType.ALL)
    private List<Adherent> adherents;
    
    @OneToOne(mappedBy = "typeMembre", cascade = CascadeType.ALL)
    private ProfilPret profilPret;
    
    // Constructeurs
    public TypeMembre() {}
    
    public TypeMembre(String code, String libelle, String description) {
        this.code = code;
        this.libelle = libelle;
        this.description = description;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    
    public String getLibelle() { return libelle; }
    public void setLibelle(String libelle) { this.libelle = libelle; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public List<Adherent> getAdherents() { return adherents; }
    public void setAdherents(List<Adherent> adherents) { this.adherents = adherents; }
    
    public ProfilPret getProfilPret() { return profilPret; }
    public void setProfilPret(ProfilPret profilPret) { this.profilPret = profilPret; }

}