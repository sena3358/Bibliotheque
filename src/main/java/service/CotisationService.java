package service;

import model.Adherent;
import model.Cotisation;
import model.StatutAdherent;
import repository.AdherentRepository;
import repository.CotisationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class CotisationService {

    @Autowired
    private CotisationRepository cotisationRepository;

    @Autowired
    private AdherentRepository adherentRepository;

    /**
     * Ajoute une nouvelle cotisation et met à jour le statut de l’adhérent.
     */
    public Cotisation ajouterCotisation(Cotisation cotisation) {
        Cotisation saved = cotisationRepository.save(cotisation);
        Adherent adherent = cotisation.getAdherent();
        adherent.setDateExpiration(cotisation.getDateFin());
        mettreAJourStatutAdherent(adherent.getId());
        adherent.setStatut(StatutAdherent.actif);
        adherentRepository.save(adherent);
        return saved;
    }

    /**
     * Vérifie si l’adhérent a une cotisation valide aujourd’hui.
     */
    public boolean aCotisationValide(Long idAdherent) {
        LocalDate aujourdHui = LocalDate.now();
        return cotisationRepository.existsByAdherentIdAndDateDebutBeforeAndDateFinAfter(
                idAdherent, aujourdHui.plusDays(1), aujourdHui.minusDays(1));
    }

    /**
     * Met à jour le statut d’un adhérent (actif / expire).
     */
    public void mettreAJourStatutAdherent(Long idAdherent) {
        Adherent adherent = adherentRepository.findById(idAdherent).orElse(null);
        if (adherent != null) {
            if (aCotisationValide(idAdherent)) {
                adherent.setStatut(StatutAdherent.actif);
            } else {
                adherent.setStatut(StatutAdherent.expire);
            }
            
            adherentRepository.save(adherent);
        }
    }

    /**
     * Met à jour tous les statuts des adhérents (ex: via cron).
     */
    public void mettreAJourTousLesStatuts() {
        List<Adherent> tous = adherentRepository.findAll();
        for (Adherent a : tous) {
            mettreAJourStatutAdherent(a.getId());
        }
    }
}
