package model;

public enum StatutProlongement {
    demande("demande"),
    approuve("approuve"),
    rejete("rejete");
    
    private final String value;
    
    StatutProlongement(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}