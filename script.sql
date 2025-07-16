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
    statut VARCHAR(10) CHECK (statut IN ('en_cours', 'retourne', 'en_retard', 'en_attente', 'rejete')),
    FOREIGN KEY (exemplaire_id) REFERENCES Exemplaire(exemplaire_id) ON DELETE CASCADE,
    FOREIGN KEY (adherent_id) REFERENCES Adherent(adherent_id) ON DELETE CASCADE
);

-- Table Reservation
CREATE TABLE Reservation (
    reservation_id SERIAL PRIMARY KEY,
    exemplaire_id INT NOT NULL,  
    adherent_id INT NOT NULL,
    date_reservation TIMESTAMP NOT NULL,
    statut VARCHAR(10) CHECK (statut IN ('en_attente', 'completee', 'annulee')) DEFAULT 'en_attente',
    FOREIGN KEY (exemplaire_id) REFERENCES Exemplaire(exemplaire_id) ON DELETE CASCADE,
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
    date_ferie DATE NOT NULL
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
    nombre_jour_penalite INT NOT,
    FOREIGN KEY (type_membre_id) REFERENCES TypeMembre(type_membre_id),
    UNIQUE (type_membre_id)
);

INSERT INTO Admin (email, mot_de_passe) VALUES
('admin@example.com', 'password123');

INSERT INTO Categorie (nom, description, couleur)
VALUES
('Littérature classique', 'Œuvres littéraires classiques', 'bleu'),
('Philosophie', 'Œuvres philosophiques', 'vert'),
('Jeunesse / Fantastique', 'Livres pour jeunes et récits fantastiques', 'violet');


INSERT INTO Livre ( isbn, titre, auteur, editeur, annee_publication, categorie_id, age_minimal, resume, langue, date_acquisition, disponible)
VALUES
( '9782070409189', 'Les Miserables', 'Victor Hugo', 'Jean', 1999, 1, 2, 'Tsisy', 'Francais', CURRENT_DATE, TRUE),
( '9782070360022', 'L''etranger', 'Albert Camus', 'Paul', 2000, 2, 2, 'Tsisy', 'Francais', CURRENT_DATE, TRUE),
( '9782070643026', 'Harry Potter à l''ecole des sorciers', 'J.K. Rowling', 'Marie', 1998, 3, 2, 'Tsisy', 'Francais', CURRENT_DATE, TRUE);

INSERT INTO Exemplaire (livre_id, code_barre, statut, date_ajout, emplacement)
VALUES
(1, 'MIS001', 'disponible', CURRENT_DATE, 'Rayon A'),
(1, 'MIS002', 'disponible', CURRENT_DATE, 'Rayon A'),
(1, 'MIS003', 'disponible', CURRENT_DATE, 'Rayon A'),
(2, 'ETR001', 'disponible', CURRENT_DATE, 'Rayon B'),
(2, 'ETR002', 'disponible', CURRENT_DATE, 'Rayon B'),
(3, 'HAR001', 'disponible', CURRENT_DATE, 'Rayon C');

INSERT INTO Adherent (
    numero_membre, nom, prenom, email, telephone, adresse, type_membre_id,
    date_de_naissance, date_inscription, date_expiration, statut
) VALUES
('ETU001', 'Bensaid', 'Amine', 'amine.bensaid@example.com', 340100001, 'Paris', 1, '2002-01-15', '2025-02-01', '2025-07-24', 'actif'),
('ETU002', 'El Khattabi', 'Sarah', 'sah.elkhattabi@example.com', 340100002, 'Lyon', 1, '2002-02-20', '2025-02-01', '2025-07-01', 'expire'),
('ETU003', 'Moujahid', 'Youssef', 'saah.elkhattabi@example.com', 340100003, 'Marseille', 1, '2002-03-25', '2025-04-01', '2025-12-01', 'actif'),
('ENS001', 'Benali', 'Nadia', 'sara.elkhattabi@example.com', 340100004, 'Toulouse', 2, '2002-04-30', '2025-07-01', '2026-07-01', 'actif'),
('ENS002', 'Haddadi', 'Karim', 'sa.elkhattabi@example.com', 340100005, 'Nice', 2, '2002-05-15', '2025-08-01', '2026-05-01', 'actif'),
('ENS003', 'Touhami', 'Salima', 'saoo.elkhattabi@example.com', 340100006, 'Strasbourg', 2, '2002-06-10', '2025-07-01', '2026-06-01', 'actif'),
('PROF001', 'El Mansouri', 'Rachid', 'rachid.elmansouri@example.com', 340200001, 'Lyon', 3, '2003-01-15', '2025-06-01', '2025-12-01', 'actif'),
('PROF002', 'Zerouali', 'Amina', 'amina.zerouali@example.com', 340200002, 'Nice', 3, '2004-12-01', '2024-10-01', '2026-06-01', 'actif');

INSERT INTO cotisation (date_paiement,date_debut, date_fin, adherent_id, montant)
VALUES 
('2025-01-30','2025-02-01', '2025-07-24', 1, 50),
('2025-01-30','2025-02-01', '2025-07-01', 2, 30),
('2025-01-30','2025-04-01', '2025-12-01', 3, 40),
('2025-01-30','2025-07-01', '2026-07-01', 4, 60),
('2025-01-30','2025-08-01', '2026-05-01', 5, 70),
('2025-01-30','2025-07-01', '2026-06-01', 6, 70),
('2025-01-30','2025-06-01', '2025-12-01', 7, 70),
('2024-09-30','2024-10-01', '2025-06-01', 8, 70);

INSERT INTO jourferie (date_ferie)
VALUES 
('2025-07-26'),
('2025-07-19');

//-------



