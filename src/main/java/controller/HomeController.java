package controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import service.CategorieService;
import service.LivreService;

@Controller
public class HomeController {
    
    @Autowired
    private LivreService livreService;
    
    @Autowired
    private CategorieService categorieService;
    
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("livres", livreService.getAllLivres());
        model.addAttribute("categories", categorieService.getAllCategories());
        return "home";
    }
}