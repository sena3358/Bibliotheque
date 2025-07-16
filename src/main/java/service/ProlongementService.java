package service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import model.Prolongement;
import repository.ProlongementRepository;

@Service
public class ProlongementService {
    
    @Autowired
    ProlongementRepository prolongementRepository;

    public List<Prolongement> findAll() {
        return prolongementRepository.findAll();
    }

    public Optional<Prolongement> findById(Long id) {
        return prolongementRepository.findById(id).orElse(null);
    }

    public void save(Prolongement prolongement) {
        prolongementRepository.save(prolongement);
    }
}
