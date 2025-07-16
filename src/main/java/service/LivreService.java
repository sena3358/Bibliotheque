package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.Categorie;
import model.Livre;
import repository.LivreRepository;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class LivreService {
    
    @Autowired
    private LivreRepository livreRepository;
    
    public List<Livre> getAllLivres() {
        return livreRepository.findAll();
    }
    
    @Transactional
    public Optional<Livre> getLivreById(Long id) {
        return livreRepository.findById(id);
    }
    
    public Optional<Livre> getLivreByIsbn(String isbn) {
        return livreRepository.findByIsbn(isbn);
    }
    
    public List<Livre> getLivresByCategorie(Categorie categorie) {
        return livreRepository.findByCategorie(categorie);
    }
    
    public List<Livre> searchLivres(String keyword) {
        return livreRepository.searchBooks(keyword);
    }
    
    public List<Livre> getAvailableLivres() {
        return livreRepository.findAvailableBooks();
    }
    
    public Livre saveLivre(Livre livre) {
        return livreRepository.save(livre);
    }
    
    public void deleteLivre(Long id) {
        livreRepository.deleteById(id);
    }
    
    public boolean existsByIsbn(String isbn) {
        return livreRepository.findByIsbn(isbn).isPresent();
    }
}