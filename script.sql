-- Creation de la base de donnees
DROP DATABASE IF EXISTS gestion_bibliotheque;
CREATE DATABASE gestion_bibliotheque ENCODING 'UTF8';
\c gestion_bibliotheque;

-- Table TypeMembre
CREATE TABLE TypeMembre (
    type_membre_id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,
    libelle VARCHAR(100) NOT NULL,
    description TEXT
);

-- Table Categorie
CREATE TABLE Categorie (
    categorie_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    couleur VARCHAR(20)
);

CREATE TABLE Admin (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
);

-- Table Livre
CREATE TABLE Livre (
    livre_id SERIAL PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE,
    titre VARCHAR(255) NOT NULL,
    auteur VARCHAR(255),
    editeur VARCHAR(255),
    annee_publication INT,
    categorie_id INT,
    age_minimal INT,
    resume TEXT,
    langue VARCHAR(50),
    date_acquisition DATE,
    disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (categorie_id) REFERENCES Categorie(categorie_id) ON DELETE SET NULL
);

-- Table Exemplaire
CREATE TABLE Exemplaire (
    exemplaire_id SERIAL PRIMARY KEY,
    livre_id INT NOT NULL,
    code_barre VARCHAR(50) UNIQUE,
    statut VARCHAR(20) CHECK (statut IN ('disponible', 'en_pret', 'en_lecture_sur_place', 'en_reparation')) DEFAULT 'disponible',
    date_ajout DATE,
    emplacement VARCHAR(100),
    FOREIGN KEY (livre_id) REFERENCES Livre(livre_id) ON DELETE CASCADE
);

-- Table Adherent
CREATE TABLE Adherent (
    adherent_id SERIAL PRIMARY KEY,
    numero_membre VARCHAR(20) UNIQUE,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    telephone VARCHAR(20),
    adresse TEXT,
    type_membre_id INT NOT NULL,
    date_de_naissance DATE,
    date_inscription DATE,
    date_expiration DATE,
    statut VARCHAR(10) CHECK (statut IN ('actif', 'suspendu', 'expire')) DEFAULT 'actif',
    FOREIGN KEY (type_membre_id) REFERENCES TypeMembre(type_membre_id)
);

-- Table Pret
CREATE TABLE Pret (
    pret_id SERIAL PRIMARY KEY,
    exemplaire_id INT NOT NULL,
    adherent_id INT NOT NULL,
    date_pret DATE NOT NULL,
    date_retour_prevue DATE NOT NULL,
    date_retour_effective DATE,
    type_pret VARCHAR(20) CHECK (type_pret IN ('maison', 'lecture_sur_place')) NOT NULL,
    statut VARCHAR(10) CHECK (statut IN ('en_cours', 'retourne', 'en_retard')) DEFAULT 'en_cours',
    FOREIGN KEY (exemplaire_id) REFERENCES Exemplaire(exemplaire_id) ON DELETE CASCADE,
    FOREIGN KEY (adherent_id) REFERENCES Adherent(adherent_id) ON DELETE CASCADE
);

-- Table Reservation
CREATE TABLE Reservation (
    reservation_id SERIAL PRIMARY KEY,
    livre_id INT NOT NULL,  -- Change de exemplaire_id à livre_id
    adherent_id INT NOT NULL,
    date_reservation TIMESTAMP NOT NULL,
    date_expiration TIMESTAMP,
    statut VARCHAR(10) CHECK (statut IN ('en_attente', 'completee', 'annulee')) DEFAULT 'en_attente',
    priorite INT,
    FOREIGN KEY (livre_id) REFERENCES Livre(livre_id) ON DELETE CASCADE,
    FOREIGN KEY (adherent_id) REFERENCES Adherent(adherent_id) ON DELETE CASCADE
);

-- Table Prolongement
CREATE TABLE Prolongement (
    prolongement_id SERIAL PRIMARY KEY,
    pret_id INT NOT NULL,
    date_demande TIMESTAMP NOT NULL,
    date_approbation TIMESTAMP,
    nouvelle_date_retour DATE,
    statut VARCHAR(10) CHECK (statut IN ('demande', 'approuve', 'rejete')) DEFAULT 'demande',
    FOREIGN KEY (pret_id) REFERENCES Pret(pret_id) ON DELETE CASCADE
);

-- Table Penalite
CREATE TABLE Penalite (
    penalite_id SERIAL PRIMARY KEY,
    pret_id INT NOT NULL,
    adherent_id INT NOT NULL,
    date_emission DATE NOT NULL,
    date_fin DATE, 
    FOREIGN KEY (pret_id) REFERENCES Pret(pret_id) ON DELETE CASCADE,
    FOREIGN KEY (adherent_id) REFERENCES Adherent(adherent_id) ON DELETE CASCADE
);

-- Table Cotisation
CREATE TABLE Cotisation (
    cotisation_id SERIAL PRIMARY KEY,
    adherent_id INT NOT NULL,
    date_paiement DATE NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    montant DECIMAL(10,2) NOT NULL,  -- Colonne ajoutee
    FOREIGN KEY (adherent_id) REFERENCES Adherent(adherent_id) ON DELETE CASCADE
);

-- Table JourFerie
CREATE TABLE JourFerie (
    jour_ferie_id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    date_ferie DATE NOT NULL,
    politique_retour VARCHAR(10) CHECK (politique_retour IN ('avant', 'apres', 'ignore')) DEFAULT 'apres'
);

-- Table Parametre
CREATE TABLE Parametre (
    parametre_id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) UNIQUE NOT NULL,
    valeur TEXT,
    description TEXT,
    date_modification TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table ProfilPret
CREATE TABLE ProfilPret (
    profil_id SERIAL PRIMARY KEY,
    type_membre_id INT NOT NULL,
    duree_pret_jours INT NOT NULL,
    nombre_max_pret INT NOT NULL,
    nombre_max_prolongement INT NOT NULL,
    delai_prolongement_jours INT NOT NULL,
    delai_de_pret INT,
    delai_de_pret_sur_place INT,
    FOREIGN KEY (type_membre_id) REFERENCES TypeMembre(type_membre_id),
    UNIQUE (type_membre_id)
);



INSERT INTO Admin (email, mot_de_passe) VALUES
('admin@example.com', 'password123');