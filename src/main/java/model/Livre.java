package model;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "livre")
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "livre_id")
    private Long id;
    
    @Column(name = "isbn", unique = true)
    private String isbn;

    @Column(name = "titre")
    private String titre;

    @Column(name = "auteur", nullable = false)
    private String auteur;

    @Column(name = "editeur")
    private String editeur;
    
    @Column(name = "annee_publication")
    private Integer anneePublication;
    
    @Column(name = "age_minimal")
    private Integer ageMinimal;

    @Column(name = "resume")
    private String resume;
    
    @Column(name = "langue")
    private String langue;
    
    @Column(name = "date_acquisition")
    private LocalDate dateAcquisition;
    
    @Column(columnDefinition = "boolean default true")
    private Boolean disponible = true;
    
    @ManyToOne
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;
    
    @JsonIgnore
    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL)
    private List<Exemplaire> exemplaires;
    
    @JsonIgnore
    @OneToMany(mappedBy = "livre", cascade = CascadeType.ALL)
    private List<Reservation> reservations;
    
    // Constructeurs
    public Livre() {}
    
    public Livre(String titre, String auteur, String isbn) {
        this.titre = titre;
        this.auteur = auteur;
        this.isbn = isbn;
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }
    
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    
    public String getAuteur() { return auteur; }
    public void setAuteur(String auteur) { this.auteur = auteur; }
    
    public String getEditeur() { return editeur; }
    public void setEditeur(String editeur) { this.editeur = editeur; }
    
    public Integer getAnneePublication() { return anneePublication; }
    public void setAnneePublication(Integer anneePublication) { this.anneePublication = anneePublication; }
    
    public Integer getAgeMinimal() { return ageMinimal; }
    public void setAgeMinimal(Integer ageMinimal) { this.ageMinimal = ageMinimal; }
    
    public String getResume() { return resume; }
    public void setResume(String resume) { this.resume = resume; }
    
    public String getLangue() { return langue; }
    public void setLangue(String langue) { this.langue = langue; }
    
    public LocalDate getDateAcquisition() { return dateAcquisition; }
    public void setDateAcquisition(LocalDate dateAcquisition) { this.dateAcquisition = dateAcquisition; }
    
    public Boolean getDisponible() { return disponible; }
    public void setDisponible(Boolean disponible) { this.disponible = disponible; }
    
    public Categorie getCategorie() { return categorie; }
    public void setCategorie(Categorie categorie) { this.categorie = categorie; }
    
    public List<Exemplaire> getExemplaires() { return exemplaires; }
    public void setExemplaires(List<Exemplaire> exemplaires) { this.exemplaires = exemplaires; }
    
    public List<Reservation> getReservations() { return reservations; }
    public void setReservations(List<Reservation> reservations) { this.reservations = reservations; }
}