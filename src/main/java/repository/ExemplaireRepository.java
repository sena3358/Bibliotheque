package repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import model.Exemplaire;
import model.Livre;
import model.StatutExemplaire;

import java.util.List;
import java.util.Optional;

@Repository
public interface ExemplaireRepository extends JpaRepository<Exemplaire, Long> {
    Optional<Exemplaire> findByCodeBarre(String codeBarre);
    List<Exemplaire> findByLivre(Livre livre);
    List<Exemplaire> findByStatut(StatutExemplaire statut);
    
    @Query("SELECT e FROM Exemplaire e WHERE e.livre = :livre AND e.statut = 'disponible'")
    List<Exemplaire> findAvailableExemplaires(@Param("livre") Livre livre);

    @Query("SELECT COUNT(e) FROM Exemplaire e WHERE e.livre = :livre AND e.statut = 'disponible'")
    Long countAvailableExemplaires(@Param("livre") Livre livre);
}