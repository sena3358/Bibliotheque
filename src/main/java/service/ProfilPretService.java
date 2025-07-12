package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.ProfilPret;
import model.TypeMembre;
import repository.ProfilPretRepository;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ProfilPretService {
    
    @Autowired
    private ProfilPretRepository profilPretRepository;
    
    public List<ProfilPret> getAllProfils() {
        return profilPretRepository.findAll();
    }
    
    public Optional<ProfilPret> getProfilById(Long id) {
        return profilPretRepository.findById(id);
    }
    
    public ProfilPret getProfilByTypeMembre(TypeMembre typeMembre) {
        return profilPretRepository.findByTypeMembre(typeMembre);
    }
    
    public ProfilPret saveProfil(ProfilPret profil) {
        return profilPretRepository.save(profil);
    }
    
    public void deleteProfil(Long id) {
        profilPretRepository.deleteById(id);
    }
}