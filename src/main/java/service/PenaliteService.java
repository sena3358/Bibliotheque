package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import model.Penalite;
import repository.PenaliteRepository;

@Service
public class PenaliteService {

    @Autowired
    PenaliteRepository penaliteRepository;

    public Penalite save(Penalite penalite){
        return penaliteRepository.save(penalite);
    }
}
