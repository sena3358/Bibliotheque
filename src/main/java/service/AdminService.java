package service;

import model.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import repository.AdminRepository;

import java.util.List;
import java.util.Optional;
@Service
@Transactional
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    public Optional<Admin> getAdminByEmail(String email) {
        return Optional.ofNullable(adminRepository.findByEmail(email));
    }

    public Admin checkLogin(String email, String motDePasse) {
        Optional<Admin> admin = getAdminByEmail(email);
        if (admin.isPresent()) {
            if (!admin.get().getMotDePasse().equals(motDePasse)) {
                throw new RuntimeException("Mot de passe incorrect");
            }
            return admin.get();
        } else {
            throw new RuntimeException("Email non trouvé");
        }
    }
}

