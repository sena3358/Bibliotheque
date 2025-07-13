package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import model.Admin;
import service.AdminService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("/loginAdmin")
    public String loginForm(Model model) {
        return "/admin/loginAdmin";
    }

    @PostMapping("/loginAdmin")
    public String login(@RequestParam("email") String email, @RequestParam("mot_de_passe") String motDePasse) {
        Admin admin = adminService.checkLogin(email, motDePasse);
        if (admin != null) {
            return "/admin/dashboard";
        } else {
            return "/admin/loginAdmin";
        }
}
}
