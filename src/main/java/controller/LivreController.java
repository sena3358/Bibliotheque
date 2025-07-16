package controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import model.Livre;
import service.CategorieService;
import service.LivreService;

import java.util.Optional;

@Controller
@RequestMapping("/livres")
public class LivreController {
    
    @Autowired
    private LivreService livreService;
    
    @Autowired
    private CategorieService categorieService;
    
    @GetMapping("/list")
    public String listLivres(Model model, @RequestParam(required = false) String search) {
        if (search != null && !search.trim().isEmpty()) {
            model.addAttribute("livres", livreService.searchLivres(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("livres", livreService.getAllLivres());
        }
        return "listLivres";
    }
    
    @GetMapping("/new")
    public String newLivre(Model model) {
        model.addAttribute("livre", new Livre());
        model.addAttribute("categories", categorieService.getAllCategories());
        return "livres/form";
    }
    
    @GetMapping("/{id}")
    public String showLivre(@PathVariable Long id, Model model) {
        Optional<Livre> livre = livreService.getLivreById(id);
        if (livre.isPresent()) {
            model.addAttribute("livre", livre.get());
            return "livres/show";
        }
        return "redirect:/livres";
    }
    
    @GetMapping("/{id}/edit")
    public String editLivre(@PathVariable Long id, Model model) {
        Optional<Livre> livre = livreService.getLivreById(id);
        if (livre.isPresent()) {
            model.addAttribute("livre", livre.get());
            model.addAttribute("categories", categorieService.getAllCategories());
            return "livres/form";
        }
        return "redirect:/livres";
    }
    
    @PostMapping
    public String saveLivre(@ModelAttribute Livre livre, RedirectAttributes redirectAttributes) {
        try {
            if (livre.getId() == null && livreService.existsByIsbn(livre.getIsbn())) {
                redirectAttributes.addFlashAttribute("error", "Un livre avec cet ISBN existe déjà");
                return "redirect:/livres/new";
            }
            
            livreService.saveLivre(livre);
            redirectAttributes.addFlashAttribute("success", "Livre sauvegardé avec succès");
            return "redirect:/livres";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la sauvegarde: " + e.getMessage());
            return "redirect:/livres/new";
        }
    }
    
    @PostMapping("/{id}/delete")
    public String deleteLivre(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            livreService.deleteLivre(id);
            redirectAttributes.addFlashAttribute("success", "Livre supprimé avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur lors de la suppression: " + e.getMessage());
        }
        return "redirect:/livres";
    }
}