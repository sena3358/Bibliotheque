package repository;

import model.ProfilPret;
import model.TypeMembre;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ProfilPretRepository extends JpaRepository<ProfilPret, Long> {
    ProfilPret findByTypeMembre(TypeMembre typeMembre);
}
