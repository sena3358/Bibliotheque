package model;

public enum StatutAdherent {
    actif("actif"),
    suspendu("suspendu"),
    expire("expire");
    
    private final String value;
    
    StatutAdherent(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}
