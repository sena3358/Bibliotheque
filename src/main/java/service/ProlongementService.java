package service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.Pret;
import model.ProfilPret;
import model.Prolongement;
import model.StatutPret;
import model.StatutProlongement;
import repository.PretRepository;
import repository.ProfilPretRepository;
import repository.ProlongementRepository;
import repository.ReservationRepository;

@Service
@Transactional
public class ProlongementService {

    @Autowired
    PretRepository pretRepository;

    @Autowired
    ProlongementRepository prolongementRepository;

    @Autowired
    ProfilPretRepository profilPretRepository;

    @Autowired
    ReservationRepository reservationRepository;

    @Transactional
    public List<Prolongement> findByStatut(){
        return prolongementRepository.findByStatut(StatutProlongement.demande);
    }

    @Transactional
    public String prolongerPret(Long pretId) {
    Optional<Pret> optionalPret = pretRepository.findById(pretId);
    

    if (optionalPret.isEmpty()) return "Prêt introuvable";

    Pret pret = optionalPret.get();
    System.out.println("Pret ID: " + pret.getId());

    // Vérification du statut
    if (!pret.getStatut().equals(StatutPret.en_cours)) return "Le prêt n'est pas actif";
    if (pret.getDateRetourPrevue().isBefore(LocalDate.now())) return "Le prêt est déjà en retard";

    // Vérification de la réservation
    //boolean livreReserve = reservationRepository.existsByLivreIdAndStatutAndDateExpirationAfter(
    //    pret.getExemplaire().getLivre().getId(), "en_attente", LocalDate.now());
//
    //if (livreReserve) return "Ce livre est réservé, vous ne pouvez pas prolonger";

    // Vérifier nombre de prolongements déjà effectués
    Long prolongementsEffectues = prolongementRepository.countByPretIdAndStatut(pretId, StatutProlongement.approuve);

    ProfilPret profil = profilPretRepository.findByTypeMembre(pret.getAdherent().getTypeMembre());
    if (prolongementsEffectues >= profil.getNombreMaxProlongement()) return "Limite de prolongements atteinte";

    // Vérifier délai minimal avant fin de prêt
    //if (ChronoUnit.DAYS.between(LocalDate.now(), pret.getDateRetourPrevue()) > profil.getDelaiProlongementJours()) {
    //    return "Trop tôt pour demander une prolongation";
    //}

    // Créer une demande de prolongement
    Prolongement prolongement = new Prolongement();
    prolongement.setPret(pret);
    prolongement.setDateDemande(LocalDateTime.now());
    prolongement.setNouvelleDateRetour(pret.getDateRetourPrevue().plusDays(profil.getDureePretJours()));
    prolongement.setStatut(StatutProlongement.demande);
    System.out.println(">>> Sauvegarde du prolongement en base...");
    prolongementRepository.save(prolongement);
    System.out.println(">>> Prolongement enregistré !");
    return "Demande de prolongement envoyée. En attente de validation";
}


    public String validerProlongement(Long prolongementId, boolean approuve) {
    Prolongement p = prolongementRepository.findById(prolongementId)
        .orElseThrow(() -> new RuntimeException("Prolongement introuvable"));

    if (!p.getStatut().equals(StatutProlongement.demande)) return "Déjà traité";

    if (approuve) {
        p.setStatut(StatutProlongement.approuve);
        p.setDateApprobation(LocalDateTime.now());

        Pret pret = p.getPret();
        pret.setDateRetourPrevue(p.getNouvelleDateRetour());
        pretRepository.save(pret);
    } else {
        p.setStatut(StatutProlongement.rejete);
    }

    prolongementRepository.save(p);
    return "Prolongement " + (approuve ? "approuvé" : "rejeté");
    }


}
