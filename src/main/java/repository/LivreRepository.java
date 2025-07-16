package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import model.Categorie;
import model.Livre;

import java.util.List;
import java.util.Optional;

@Repository
public interface LivreRepository extends JpaRepository<Livre, Long> {
    Optional<Livre> findByIsbn(String isbn);
    List<Livre> findByCategorie(Categorie categorie);
    List<Livre> findByAuteurContainingIgnoreCase(String auteur);
    List<Livre> findByTitreContainingIgnoreCase(String titre);
    
    @Query("SELECT l FROM Livre l WHERE l.disponible = true")
    List<Livre> findAvailableBooks();
    
    @Query("SELECT l FROM Livre l WHERE l.titre LIKE %:keyword% OR l.auteur LIKE %:keyword% OR l.isbn LIKE %:keyword%")
    List<Livre> searchBooks(@Param("keyword") String keyword);
}