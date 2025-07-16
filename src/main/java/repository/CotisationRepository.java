package repository;

import model.Cotisation;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CotisationRepository extends JpaRepository<Cotisation, Long> {

    boolean existsByAdherentIdAndDateDebutBeforeAndDateFinAfter(Long idAdherent, LocalDate plusDays,
            LocalDate minusDays);
    
}
