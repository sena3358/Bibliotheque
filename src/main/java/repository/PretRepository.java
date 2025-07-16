package repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import model.Adherent;
import model.Pret;
import model.StatutPret;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PretRepository extends JpaRepository<Pret, Long> {
    List<Pret> findByAdherent(Adherent adherent);
    List<Pret> findByStatut(StatutPret statut);
    
    @Query("SELECT p FROM Pret p WHERE p.adherent = :adherent AND p.statut = 'en_cours'")
    List<Pret> findActiveLoans(@Param("adherent") Adherent adherent);

    @Query("SELECT p FROM Pret p WHERE p.dateRetourPrevue < :date AND p.statut = 'en_cours'")
    List<Pret> findOverdueLoans(@Param("date") LocalDate date);

    @Query("SELECT COUNT(p) FROM Pret p WHERE p.adherent = :adherent AND p.statut = 'en_cours'")
    Long countActiveLoans(@Param("adherent") Adherent adherent);
    long countByAdherentIdAndStatut(Long adherentId, StatutPret enCours);

    List<Pret> findByAdherentId(Long adherentId);
    List<Pret> findByExemplaireId(Long exemplaireId);
}