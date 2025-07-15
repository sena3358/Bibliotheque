package controller;

import model.Adherent;
import model.Exemplaire;
import model.Penalite;
import model.Pret;
import model.StatutAdherent;
import model.StatutExemplaire;
import model.StatutPret;
import model.TypePret;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import service.PretService;
import service.AdherentService;
import service.ExemplaireService;
import service.LivreService;
import service.PenaliteService;

@Controller
@RequestMapping("/prets")
public class PretController {

    @Autowired
    private PretService pretService;

    @Autowired 
    private AdherentService adherentService;

    @Autowired
    private ExemplaireService exemplaireService;

    @Autowired
    private LivreService livreService;

    @Autowired
    private PenaliteService penaliteService;

    @GetMapping("/form")
    public String showForm() {
        return "pret_form";
    }

    @PostMapping("/create")
    public String effectuerPret(@RequestParam("adherent_id") Long adherentId,
                                @RequestParam("exemplaire_id") Long exemplaireId,
                                @RequestParam("type_pret") TypePret typePret,
                                @RequestParam("date_pret") LocalDate datePret,
                                Model model) {
        String message = pretService.effectuerPret(adherentId, exemplaireId, typePret, datePret);
        model.addAttribute("message", message);
        return "pret_result";
    }

    @GetMapping("/liste")
    public String listPrets(Model model, HttpSession session) {
        Long id = (Long) session.getAttribute("id_adherent");
        if (id != null) {
            model.addAttribute("id", id);
            model.addAttribute("prets", pretService.getPretsParAdherent(id));
            model.addAttribute("exemplaires", exemplaireService.findAll());
            model.addAttribute("livres", livreService.getAllLivres());
            return "pret_list";    
        } else {
        model.addAttribute("prets", pretService.getAllPrets());
        model.addAttribute("exemplaires", exemplaireService.findAll());
        model.addAttribute("livres", livreService.getAllLivres());
        return "pret_list";
        }
    }
//--demande

    @GetMapping("/formulaire")
    public String afficherFormulairePret(Model model, HttpSession session) {
        Long adherentId = (Long) session.getAttribute("id_adherent");
        List<Exemplaire> exemplairesDispo = exemplaireService.findByStatut(StatutExemplaire.disponible);
        model.addAttribute("exemplaires", exemplairesDispo);
        model.addAttribute("adherentId", adherentId);
        return "pret_demande";
    }

    @GetMapping("/demandes")
    public String afficherDemandes(Model model) {
        List<Pret> demandes = pretService.listerDemandesEnAttente();
        model.addAttribute("demandes", demandes);
        return "admin/demandes_pret";
    }
 
    @PostMapping("/valider")
    public String validerPret(@RequestParam("pret_id") Long pretId,
                              @RequestParam("approuve") boolean approuve,
                              HttpServletRequest request,
                              Model model) {

        String message = pretService.validerPret(pretId, approuve);
        request.getSession().setAttribute("message", message);

        return "redirect:/prets/demandes";
    }

    @PostMapping("/demander")
    public String demanderPret(@RequestParam("adherentId") Long adherentId,
                               @RequestParam("exemplaireId") Long exemplaireId,
                               @RequestParam("type") TypePret typePret,
                               @RequestParam("date_pret") LocalDate datePret,
                               HttpServletRequest request) {

        String message = pretService.demanderPret(adherentId, exemplaireId, typePret, datePret);
        request.getSession().setAttribute("message", message);
        return "redirect:/prets/liste";
    }

//--rendre
    @PostMapping("/rendre")
    public String rendrePret(
    @RequestParam("id") Long id,
    @RequestParam("date_retour_prevue") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dateRetourEffective,RedirectAttributes redirectAttributes
    ) {
    Pret pret = pretService.findById(id);

    if (pret == null) {
        redirectAttributes.addFlashAttribute("error", "Prêt introuvable");
        return "redirect:/prets/liste";
    }

    pret.setDateRetourEffective(dateRetourEffective);

    // Vérifie si c’est en retard
    if (dateRetourEffective.isAfter(pret.getDateRetourPrevue())) {
        pret.setStatut(StatutPret.en_retard);

        Adherent adherent = pret.getAdherent();
        adherent.setStatut(StatutAdherent.suspendu);
        adherent.setDateExpiration(dateRetourEffective.plusDays(10));
        adherentService.saveAdherent(adherent);
        Penalite penalite = new Penalite();
        penalite.setDateEmission(dateRetourEffective);
        penalite.setDateFin(dateRetourEffective.plusDays(10));
        penalite.setPret(pret);
        penalite.setAdherent(adherent);
        penaliteService.save(penalite);
    } else {
        pret.setStatut(StatutPret.retourne);
    }

    Exemplaire exemplaire = pret.getExemplaire();
    exemplaire.setStatut(StatutExemplaire.disponible);
    exemplaireService.saveExemplaire(exemplaire);

    pretService.save(pret);

    redirectAttributes.addFlashAttribute("success", "Retour enregistré");
    return "redirect:/prets/liste";
}
}