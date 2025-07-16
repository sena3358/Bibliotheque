package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import model.Exemplaire;
import model.StatutExemplaire;
import repository.ExemplaireRepository;

@Service
public class ExemplaireService {
    @Autowired
    private ExemplaireRepository exemplaireRepository;

    public List<Exemplaire> findAll() {
        return exemplaireRepository.findAll();
    }

    public Exemplaire findById(Long id) {
        return exemplaireRepository.findById(id).orElse(null);
    }

    public void saveExemplaire(Exemplaire exemplaire) {
        exemplaireRepository.save(exemplaire);
    }

    public List<Exemplaire> findByStatut(StatutExemplaire disponible) {
        return exemplaireRepository.findByStatut(disponible);
    }
}
