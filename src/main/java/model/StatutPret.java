package model;

public enum StatutPret {
    en_cours("en_cours"),
    retourne("retourne"),
    en_retard("en_retard"),
    en_attente("en_attente"),
    rejete("rejete");
    
    private final String value;
    
    StatutPret(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}
