package model;

public enum TypePret {
    maison("maison"),
    lecture_sur_place("lecture_sur_place");
    
    private final String value;
    
    TypePret(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
}
