package repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import model.Adherent;
import model.Livre;
import model.Reservation;
import model.StatutReservation;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findByAdherent(Adherent adherent);
    List<Reservation> findByLivre(Livre livre);
    List<Reservation> findByStatut(StatutReservation statut);
    
    @Query("SELECT r FROM Reservation r WHERE r.livre = :livre AND r.statut = 'en_attente' ORDER BY r.dateReservation ASC")
    List<Reservation> findPendingReservations(@Param("livre") Livre livre);

    @Query("SELECT r FROM Reservation r WHERE r.dateExpiration < :date AND r.statut = 'en_attente'")
    List<Reservation> findExpiredReservations(@Param("date") LocalDateTime date);

    @Query("SELECT COUNT(r) FROM Reservation r WHERE r.adherent = :adherent AND r.statut = 'en_attente'")
    Long countActiveReservations(@Param("adherent") Adherent adherent);
}