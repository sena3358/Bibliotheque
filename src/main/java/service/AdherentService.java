package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpSession;
import model.Adherent;
import model.StatutAdherent;
import repository.AdherentRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class AdherentService {
    
    @Autowired
    private AdherentRepository adherentRepository;
    
    public List<Adherent> getAllAdherents() {
        return adherentRepository.findAll();
    }
    
    public Optional<Adherent> getAdherentById(Long id) {
        return adherentRepository.findById(id);
    }
    
    public List<Adherent> getAdherentByNumeroMembre(String numeroMembre) {
        return adherentRepository.findByNumeroMembre(numeroMembre);
    }
    
    public Optional<Adherent> getAdherentByEmail(String email) {
        return adherentRepository.findByEmail(email);
    }
    
    public List<Adherent> searchAdherents(String keyword) {
        return adherentRepository.searchAdherents(keyword);
    }
    
    public List<Adherent> getExpiredMembers() {
        return adherentRepository.findExpiredMembers(LocalDate.now());
    }
    
    public Adherent saveAdherent(Adherent adherent) {
        if (adherent.getNumeroMembre() == null) {
            adherent.setNumeroMembre(generateNumeroMembre());
        }
        return adherentRepository.save(adherent);
    }
    
    public void deleteAdherent(Long id) {
        adherentRepository.deleteById(id);
    }
    
    public void updateStatutAdherent(Long id, StatutAdherent statut) {
        Optional<Adherent> adherentOpt = adherentRepository.findById(id);
        if (adherentOpt.isPresent()) {
            Adherent adherent = adherentOpt.get();
            adherent.setStatut(statut);
            adherentRepository.save(adherent);
        }
    }
    
    private String generateNumeroMembre() {
        // Génération simple du numéro de membre
        return "ADH" + System.currentTimeMillis();
    }
    
    public boolean canBorrow(Adherent adherent) {
        return adherent.getStatut() == StatutAdherent.actif && 
               adherent.getDateExpiration().isAfter(LocalDate.now());
    }

    public Adherent checkLogin(String numeroMembre) {
        List<Adherent> adherentOpt = adherentRepository.findByNumeroMembre(numeroMembre);
        if (adherentOpt.isEmpty()) {
            return null;
        } else {
            return adherentOpt.get(0);
        }
    }

    public Adherent getAdherentFromSession(HttpSession session) {
        Long adherentId = (Long) session.getAttribute("adherentId");
        if (adherentId != null) {
            return adherentRepository.findById(adherentId).orElse(null);
        }
        return null;
    }

}