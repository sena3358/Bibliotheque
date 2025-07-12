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

    // Vérification d'âge requis
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
