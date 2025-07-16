package service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import model.Categorie;
import repository.CategorieRepository;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CategorieService {
    
    @Autowired
    private CategorieRepository categorieRepository;
    
    public List<Categorie> getAllCategories() {
        return categorieRepository.findAll();
    }
    
    public Optional<Categorie> getCategorieById(Long id) {
        return categorieRepository.findById(id);
    }
    
    public Optional<Categorie> getCategorieByNom(String nom) {
        return categorieRepository.findByNom(nom);
    }
    
    public Categorie saveCategorie(Categorie categorie) {
        return categorieRepository.save(categorie);
    }
    
    public void deleteCategorie(Long id) {
        categorieRepository.deleteById(id);
    }
    
    public boolean existsByNom(String nom) {
        return categorieRepository.existsByNom(nom);
    }
}