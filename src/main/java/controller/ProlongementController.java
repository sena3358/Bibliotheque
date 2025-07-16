package controller;

import jakarta.transaction.Transactional;
import model.Prolongement;
import model.Pret;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import repository.PretRepository;
import repository.ProfilPretRepository;
import repository.ProlongementRepository;
import service.ProlongementService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/prolongements")
public class ProlongementController {

    @Autowired
    private ProlongementService prolongementService;

    // Demander prolongement
    @PostMapping("/demander")
    public String demanderProlongement(@RequestParam("id") Long pretId, RedirectAttributes redirectAttributes) {
    String resultat = prolongementService.prolongerPret(pretId);
    redirectAttributes.addFlashAttribute("message", resultat);
    return "redirect:/prets/liste";
    }


    // Liste des prolongements à valider (admin)
    @GetMapping("/list")
    public String afficherDemandes(Model model) {
        List<Prolongement> demandes = prolongementService.findByStatut();
        model.addAttribute("demandes", demandes);
        return "/admin/prolongement_list";
    }

    // Valider ou refuser une demande
    @PostMapping("/admin/valider")
    public String valider(@RequestParam("prolongement_Id") Long prolongementId, @RequestParam("approuve") boolean approuve) {
        prolongementService.validerProlongement(prolongementId, approuve);
        return "/admin/prolongement_list";
    }
}
