package repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import model.Prolongement;
import model.StatutProlongement;

@Repository
public interface ProlongementRepository extends JpaRepository<Prolongement, Long>{

    long countByPretIdAndStatut(Long pretId, StatutProlongement approuve);

    List<Prolongement> findByStatut(StatutProlongement demande);
    
}
