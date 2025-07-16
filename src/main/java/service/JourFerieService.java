package service;

import java.time.DayOfWeek;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import repository.JourFerieRepository;

@Service
public class JourFerieService {
    @Autowired
    private JourFerieRepository jourFerieRepository;

    public boolean estJourNonOuvrable(LocalDate date) {
    if (date.getDayOfWeek() == DayOfWeek.SUNDAY) return true;

    // Jour férié dans la base de données
    return jourFerieRepository.existsByDateFerie(date);
}

    public LocalDate prochainJourOuvrable(LocalDate date) {
        while (jourFerieRepository.existsByDateFerie(date) || date.getDayOfWeek() == DayOfWeek.SUNDAY) {
            date = date.plusDays(1);
        }
        return date;
    }
}
