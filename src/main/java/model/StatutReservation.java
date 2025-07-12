package model;

public enum StatutReservation {
    EN_ATTENTE("en_attente"),
    COMPLETEE("completee"),
    ANNULEE("annulee");
    
    private final String value;
    
    StatutReservation(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}
