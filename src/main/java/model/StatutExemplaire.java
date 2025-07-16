package model;

public enum StatutExemplaire {
    disponible("disponible"),
    en_pret("en_pret"),
    en_lecture_sur_place("en_lecture_sur_place"),
    en_reparation("en_reparation");
    
    private final String value;
    
    StatutExemplaire(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}
