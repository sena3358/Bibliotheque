package controller;


import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import model.Adherent;
import model.Cotisation;
import model.Pret;
import model.StatutAdherent;
import service.*;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/adherent")
public class AdherentController {

    @Autowired
    private AdherentService adherentService;

    @Autowired
    private LivreService livreService;

    @Autowired
    private CategorieService categorieService;

    @Autowired
    private ExemplaireService exemplaireService;

    @Autowired
    private CotisationService cotisationService;

    @GetMapping("/login")
    public String loginForm(Model model) {
        return "login";
    }

    @PostMapping("/login")
    public String checkLogin(@RequestParam("numero_membre") String numeroMembre, Model model, HttpSession session) {
        Adherent adherent = adherentService.checkLogin(numeroMembre);
        if (adherent != null) {
            session.setAttribute("id_adherent", adherent.getId());
            model.addAttribute("livres", livreService.getAllLivres());
            model.addAttribute("categories", categorieService.getAllCategories());
            model.addAttribute("exemplaires", exemplaireService.findAll());
            return "accueil";
        } else {
            return "login";
        }
    }

    @GetMapping("/list")
    public String listeAdherents(Model model) {
        List<Adherent> adherents = adherentService.getAllAdherents();
        model.addAttribute("adherents", adherents); 
        return "/admin/adherent_list";
    }

    @PostMapping("/activer")
    public String activerAdherent(@RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
    Optional<Adherent> optional = adherentService.getAdherentById(id);
    if (optional.isPresent()) {
        Adherent adherent = optional.get();
        adherent.setStatut(StatutAdherent.actif);
        adherentService.saveAdherent(adherent);
        redirectAttributes.addFlashAttribute("message", "Statut activé avec succès.");
    } else {
        redirectAttributes.addFlashAttribute("message", "Adhérent introuvable.");
    }
    return "redirect:/adherent/list";
    }

//--Cotix    
    @GetMapping("/form")
    public String showForm(Model model, HttpSession session) {
        Long adherentId = (Long) session.getAttribute("id_adherent");
        model.addAttribute("adherentId", adherentId);
        return "cotisation_form"; 
    }

    @PostMapping("/save")
    public String enregistrerCotisation(
            @RequestParam("adherentId") Long adherentId,
            @RequestParam("date_debut") String dateDebut,
            @RequestParam("date_fin") String dateFin,
            @RequestParam("montant") BigDecimal montant,
            Model model
    ) {
        Optional<Adherent> adherent = adherentService.getAdherentById(adherentId);
        if (!adherent.isPresent()) {
            model.addAttribute("message", "Adhérent introuvable.");
            return "cotisation_form";
        }

        Cotisation cotisation = new Cotisation();
        cotisation.setAdherent(adherent.get());
        cotisation.setDatePaiement(LocalDate.now());
        cotisation.setDateDebut(LocalDate.parse(dateDebut));
        cotisation.setDateFin(LocalDate.parse(dateFin));
        cotisation.setMontant(montant);

        cotisationService.ajouterCotisation(cotisation);

        model.addAttribute("message", "Cotisation enregistrée avec succès !");
        return "redirect:/adherent/form";
    }
 
}