package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Penalite;

@Repository
public interface PenaliteRepository extends JpaRepository<Penalite, Long>{
    
}
