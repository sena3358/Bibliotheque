package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.Adherent;
import model.Exemplaire;
import model.Livre;
import model.Pret;
import model.ProfilPret;
import model.StatutAdherent;
import model.StatutExemplaire;
import model.StatutPret;
import model.TypePret;
import repository.ExemplaireRepository;
import repository.PretRepository;
import repository.AdherentRepository;
import repository.ProfilPretRepository;


import java.time.LocalDate;
import java.time.Period;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class PretService {
    
    @Autowired
    private PretRepository pretRepository;
    
    @Autowired
    private ExemplaireRepository exemplaireRepository;
    
    @Autowired
    private AdherentService adherentService;
    
    @Autowired
    private ProfilPretService profilPretService;

    @Autowired
    private AdherentRepository adherentRepository;

    @Autowired
    private ProfilPretRepository profilPretRepository;
    
    public List<Pret> getAllPrets() {
        return pretRepository.findAll();
    }
    
    public Optional<Pret> getPretById(Long id) {
        return pretRepository.findById(id);
    }

    
    public List<Pret> getPretsByAdherent(Adherent adherent) {
        return pretRepository.findByAdherent(adherent);
    }
    
    public List<Pret> getActivePrets(Adherent adherent) {
        return pretRepository.findActiveLoans(adherent);
    }
    
    public List<Pret> getOverdueLoans() {
        return pretRepository.findOverdueLoans(LocalDate.now());
    }

    @SuppressWarnings("unlikely-arg-type")
    @Transactional
    public String effectuerPret(Long adherentId, Long exemplaireId, TypePret typePret) {
    Optional<Adherent> optionalAdherent = adherentRepository.findById(adherentId);
    Optional<Exemplaire> optionalExemplaire = exemplaireRepository.findById(exemplaireId);

    if (optionalAdherent.isEmpty() || optionalExemplaire.isEmpty()) return "Adhérent ou exemplaire introuvable.";

    Adherent adherent = optionalAdherent.get();
    Exemplaire exemplaire = optionalExemplaire.get();

    if (!adherent.getStatut().equals(StatutAdherent.actif)) return "Adhérent inactif";
    if (!exemplaire.getStatut().equals(StatutExemplaire.disponible)) return "Exemplaire indisponible";
    if (adherent.getDateExpiration().isBefore(LocalDate.now())) return "Veuillez vous reabonnee";

    Livre livre = exemplaire.getLivre();
    if (livre.getAgeMinimal() != null && adherent.getDateDeNaissance() != null) {
        int age = Period.between(adherent.getDateDeNaissance(), LocalDate.now()).getYears();
        if (age < livre.getAgeMinimal()) {
            return "Âge insuffisant pour emprunter ce livre (âge requis : " + livre.getAgeMinimal() + ")";
        }
    }

    long nombrePretsActifs = pretRepository.countByAdherentIdAndStatut(adherentId, StatutPret.en_cours);
    ProfilPret profil = profilPretRepository.findByTypeMembre(adherent.getTypeMembre());

    if (nombrePretsActifs >= profil.getNombreMaxPret()) return "Nombre de prêts maximum atteint";

    LocalDate datePret = LocalDate.now();
    LocalDate dateRetourPrevue = datePret.plusDays(profil.getDureePretJours());

    Pret pret = new Pret();
    pret.setAdherent(adherent);
    pret.setExemplaire(exemplaire);
    pret.setDatePret(datePret);
    pret.setDateRetourPrevue(dateRetourPrevue);
    pret.setTypePret(typePret);
    pret.setStatut(StatutPret.en_cours);

    exemplaire.setStatut(StatutExemplaire.en_pret);

    pretRepository.save(pret);
    exemplaireRepository.save(exemplaire);

    return "Prêt effectué avec succès";
}

 @Transactional
    public String demanderPret(Long adherentId, Long exemplaireId, TypePret typePret) {
        Optional<Adherent> optionalAdherent = adherentRepository.findById(adherentId);
        Optional<Exemplaire> optionalExemplaire = exemplaireRepository.findById(exemplaireId);

        
        if (optionalAdherent.isEmpty() || optionalExemplaire.isEmpty()) {
            return "Adhérent ou exemplaire introuvable.";
        }

        Adherent adherent = optionalAdherent.get();
        Exemplaire exemplaire = optionalExemplaire.get();

        if (!adherent.getStatut().equals(StatutAdherent.actif)) {
            return "Adhérent inactif";
        }

        if (!exemplaire.getStatut().equals(StatutExemplaire.disponible)) {
            return "Exemplaire non disponible";
        }

        Livre livre = exemplaire.getLivre();
        if (livre.getAgeMinimal() != null && adherent.getDateDeNaissance() != null) {
            int age = Period.between(adherent.getDateDeNaissance(), LocalDate.now()).getYears();
            if (age < livre.getAgeMinimal()) {
                return "Âge insuffisant pour emprunter ce livre (âge requis : " + livre.getAgeMinimal() + ")";
            }
        }

        long pretsEnCours = pretRepository.countByAdherentIdAndStatut(adherentId, StatutPret.en_cours);
        ProfilPret profil = profilPretRepository.findByTypeMembre(adherent.getTypeMembre());

        if (pretsEnCours >= profil.getNombreMaxPret()) {
            return "Limite de prêts atteinte";
        }

        if (adherent.getDateExpiration().isBefore(LocalDate.now())) return "Veuillez vous réabonner";

        Pret pret = new Pret();
        pret.setAdherent(adherent);
        pret.setExemplaire(exemplaire);
        pret.setDatePret(LocalDate.now());
        pret.setDateRetourPrevue(LocalDate.now().plusDays(profil.getDureePretJours()));
        pret.setTypePret(typePret);
        pret.setStatut(StatutPret.en_attente);

        pretRepository.save(pret);

        return "Demande de prêt envoyée. En attente de validation.";
    }

    /**
     * Validation par l’administrateur
     */
    @Transactional
    public String validerPret(Long pretId, boolean approuve) {
        Optional<Pret> optionalPret = pretRepository.findById(pretId);

        if (optionalPret.isEmpty()) {
            return "Prêt introuvable";
        }

        Pret pret = optionalPret.get();

        if (pret.getStatut() != StatutPret.en_attente) {
            return "Le prêt n'est pas en attente";
        }

        if (approuve) {
            ProfilPret profil = profilPretRepository.findByTypeMembre(pret.getAdherent().getTypeMembre());

            pret.setDatePret(LocalDate.now());
            pret.setDateRetourPrevue(LocalDate.now().plusDays(profil.getDureePretJours()));
            pret.setStatut(StatutPret.en_cours);

            pret.getExemplaire().setStatut(StatutExemplaire.en_pret);
            exemplaireRepository.save(pret.getExemplaire());

        } else {
            pret.setStatut(StatutPret.rejete);
        }

        pretRepository.save(pret);
        return approuve ? "Prêt validé avec succès" : "Demande de prêt rejetée";
    }

    /**
     * Liste des prêts en attente
     */
    public List<Pret> listerDemandesEnAttente() {
        return pretRepository.findByStatut(StatutPret.en_attente);
    }

    /**
     * Liste des prêts d’un adhérent
     */
    public List<Pret> pretsParAdherent(Long adherentId) {
        return pretRepository.findByAdherentId(adherentId);
    }


    public List<Pret> getPretsParExemplaire(Long exemplaireId) {
        return pretRepository.findByExemplaireId(exemplaireId);
    }

    public List<Pret> getPretsParAdherent(Long adherentId) {
        return pretRepository.findByAdherentId(adherentId);
    }

    public Pret findById(Long id) {
        return pretRepository.findById(id).orElse(null);
    }
    public Pret save(Pret pret) {
        return pretRepository.save(pret);
    }
    
}
