package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import model.Adherent;
import model.StatutAdherent;
import model.TypeMembre;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AdherentRepository extends JpaRepository<Adherent, Long> {
    
    List<Adherent> findByNumeroMembre(String numeroMembre);
    Optional<Adherent> findByEmail(String email);
    List<Adherent> findByTypeMembre(TypeMembre typeMembre);
    List<Adherent> findByStatut(StatutAdherent statut);
    
    @Query("SELECT a FROM Adherent a WHERE a.dateExpiration < :date AND a.statut = 'ACTIF'")
    List<Adherent> findExpiredMembers(@Param("date") LocalDate date);
    
    @Query("SELECT a FROM Adherent a WHERE a.nom LIKE %:keyword% OR a.prenom LIKE %:keyword% OR a.numeroMembre LIKE %:keyword%")
    List<Adherent> searchAdherents(@Param("keyword") String keyword);
    
}