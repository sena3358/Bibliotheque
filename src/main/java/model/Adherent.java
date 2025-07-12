package model;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "adherent")
public class Adherent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "adherent_id")
    private Long id;
    
    @Column(name = "numero_membre", unique = true)
    private String numeroMembre;
    
    @Column(name = "nom", nullable = false)
    private String nom;
    
    @Column(name = "prenom", nullable = false)
    private String prenom;
    
    @Column(name = "email", unique = true)
    private String email;
    
    @Column(name = "telephone")
    private String telephone;
    
    @Column(name = "adresse")
    private String adresse;
    
    @Column(name = "date_de_naissance")
    private LocalDate dateDeNaissance;
    
    @Column(name = "date_inscription")
    private LocalDate dateInscription;
    
    @Column(name = "date_expiration")
    private LocalDate dateExpiration;
    
    @Enumerated(EnumType.STRING)
    private StatutAdherent statut = StatutAdherent.actif;
    
    @ManyToOne
    @JoinColumn(name = "type_membre_id", nullable = false)
    private TypeMembre typeMembre;
    
    @OneToMany(mappedBy = "adherent", cascade = CascadeType.ALL)
    private List<Pret> prets;
    
    @OneToMany(mappedBy = "adherent", cascade = CascadeType.ALL)
    private List<Reservation> reservations;
    
    @OneToMany(mappedBy = "adherent", cascade = CascadeType.ALL)
    private List<Cotisation> cotisations;
    
    // Constructeurs
    public Adherent() {}
    
    public Adherent(String nom, String prenom, String email, TypeMembre typeMembre) {
        this.nom = nom;
        this.prenom = prenom;
        this.email = email;
        this.typeMembre = typeMembre;
        this.dateInscription = LocalDate.now();
    }
    
    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNumeroMembre() { return numeroMembre; }
    public void setNumeroMembre(String numeroMembre) { this.numeroMembre = numeroMembre; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
    
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    
    public LocalDate getDateDeNaissance() { return dateDeNaissance; }
    public void setDateDeNaissance(LocalDate dateDeNaissance) { this.dateDeNaissance = dateDeNaissance; }
    
    public LocalDate getDateInscription() { return dateInscription; }
    public void setDateInscription(LocalDate dateInscription) { this.dateInscription = dateInscription; }
    
    public LocalDate getDateExpiration() { return dateExpiration; }
    public void setDateExpiration(LocalDate dateExpiration) { this.dateExpiration = dateExpiration; }
    
    public StatutAdherent getStatut() { return statut; }
    public void setStatut(StatutAdherent statut) { this.statut = statut; }
    
    public TypeMembre getTypeMembre() { return typeMembre; }
    public void setTypeMembre(TypeMembre typeMembre) { this.typeMembre = typeMembre; }
    
    public List<Pret> getPrets() { return prets; }
    public void setPrets(List<Pret> prets) { this.prets = prets; }
    
    public List<Reservation> getReservations() { return reservations; }
    public void setReservations(List<Reservation> reservations) { this.reservations = reservations; }
    
    public List<Cotisation> getCotisations() { return cotisations; }
    public void setCotisations(List<Cotisation> cotisations) { this.cotisations = cotisations; }
}