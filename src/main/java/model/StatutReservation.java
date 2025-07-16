package model;

public enum StatutReservation {
    en_attente("en_attente"),
    completee("completee"),
    annulee("annulee");
    
    private final String value;
    
    StatutReservation(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}
