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

INSERT INTO droit (nom)
VALUES 
  ('Adherant'),
  ('livre'),
  ('pret'),
  ('penalite'),
  ('reservation'),
  ('prolongation');


INSERT INTO personnel (nom, prenom, email, contact, mot_de_passe, etat, date_modification, id_type_utilisateur)
VALUES 
('Randri', 'Laurent', 'admin@example.com', 340123456, 'admin123', TRUE, CURDATE(), 1),
('Rakoto', 'Jean', 'jean.biblio@example.com', 340654321, 'biblio123', TRUE, CURDATE(), 2),
('Rasoa', 'Marie', 'marie.biblio@example.com', 340112233, 'biblio456', TRUE, CURDATE(), 2);

INSERT INTO type_adherant (
   nom, description, limite_emprunt, limite_prolongation, 
   limite_reservation, duree_pret, duree_prolongation, 
   etat, date_modification, duree_penalite
) VALUES 
('Etudiant', 'Adhérent étudiant, prêt limité', 2, 3, 1, 7, 7, TRUE, CURDATE(), 10),
('Enseignant', 'Adhérent enseignant, accès intermédiaire', 3, 5, 2, 9, 9, TRUE, CURDATE(), 9),
('Professionnel', 'Adhérent professionnel, durée prolongée', 4, 7, 3, 12, 12, TRUE, CURDATE(), 8);

INSERT INTO adherant (nom, prenom, email, contact, adresse, date_naissance, photo, etat, date_modification, id_type_utilisateur, id_type_adherant)
VALUES
('Bensaïd', 'Amine', 'amine.bensaid@example.com', 340100001, 'ETU001', '2002-01-15', 'amine.jpg', TRUE, CURDATE(), 3, 1),
('El Khattabi', 'Sarah', 'sarah.elkhattabi@example.com', 340100002, 'ETU002', '2001-03-22', 'sarah.jpg', TRUE, CURDATE(), 3, 1),
('Moujahid', 'Youssef', 'youssef.moujahid@example.com', 340100003, 'ETU003', '2003-06-18', 'youssef.jpg', TRUE, CURDATE(), 3, 1),
('Benali', 'Nadia', 'nadia.benali@example.com', 340200001, 'ENS001', '1980-07-09', 'nadia.jpg', TRUE, CURDATE(), 3, 2),
('Haddadi', 'Karim', 'karim.haddadi@example.com', 340200002, 'ENS002', '1978-11-30', 'karim.jpg', TRUE, CURDATE(), 3, 2),
('Touhami', 'Salima', 'salima.touhami@example.com', 340200003, 'ENS003', '1983-04-05', 'salima.jpg', TRUE, CURDATE(), 3, 2),
('El Mansouri', 'Rachid', 'rachid.elmansouri@example.com', 340300001, 'PROF001', '1975-09-17', 'rachid.jpg', TRUE, CURDATE(), 3, 3),
('Zerouali', 'Amina', 'amina.zerouali@example.com', 340300002, 'PROF002', '1988-12-12', 'amina.jpg', TRUE, CURDATE(), 3, 3);

INSERT INTO type_de_pret (nom, etat, date_modification)
VALUES 
('Sur place', TRUE, CURDATE()),
('Reservation', TRUE, CURDATE()),
('Emporter', TRUE, CURDATE());

INSERT INTO status_pret (nom)
VALUES 
('Reserver'),
('En cours'),
('En retard'),
('Terminer'),
('Annuler');

INSERT INTO status_penalite (nom)
VALUES 
('En cours'),
('Terminer'),
('Annuler');

-- Cotisation
INSERT INTO cotisation (date_debut, date_fin, id_adherant)
VALUES 
('2025-02-01', '2025-07-24', 1),
('2025-02-01', '2025-07-01', 2),
('2025-04-01', '2025-12-01', 3),
('2025-07-01', '2026-07-01', 4),
('2025-08-01', '2026-05-01', 5),
('2025-07-01', '2026-06-01', 6),
('2025-06-01', '2025-12-01', 7),
('2024-10-01', '2025-06-01', 8);

INSERT INTO genre (nom)
VALUES 
('Comédie'),
('Drame'),
('Science-fiction'),
('Fantastique'),
('Horreur'),
('Aventure'),
('Romance'),
('Policier');

INSERT INTO type_livre (nom)
VALUES
('Roman'),
('Manuel'),
('Bande dessinée'),
('Essai'),
('Science'),
('Histoire'),
('Poésie'),
('Théâtre');

INSERT INTO livre (titre, auteur, editeur, ISBN, annee_publication, nombre_exemplaire, etat, date_modification, age_minimum, id_type_livre)
VALUES
('Les Misérables', 'Victor Hugo', NULL, '9782070409189', '1862-01-01', 3, TRUE, CURDATE(), 20, 1),
('L''Étranger', 'Albert Camus', NULL, '9782070360022', '1942-05-01', 2, TRUE, CURDATE(), 20, 1),
('Harry Potter à l''école des sorciers', 'J.K. Rowling', NULL, '9782070643026', '1997-06-26', 1, TRUE, CURDATE(), 20, 1);

INSERT INTO status_exemplaire (nom)
VALUES 
('Neuf'),
('Très bon état'),
('Bon état'),
('Acceptable'),
('Usé'),
('À réparer'),
('Inutilisable');

-- Exemplaires pour "Les Misérables" (id_livre = 1)
INSERT INTO exemplaire (etat, date_modification, id_status_exemplaire, id_livre)
VALUES
(TRUE, CURDATE(), 1, 1),
(TRUE, CURDATE(), 1, 1),
(TRUE, CURDATE(), 1, 1);

-- Exemplaires pour "L'Étranger" (id_livre = 2)
INSERT INTO exemplaire (etat, date_modification, id_status_exemplaire, id_livre)
VALUES
(TRUE, CURDATE(), 1, 2),
(TRUE, CURDATE(), 1, 2);

-- Exemplaire pour "Harry Potter à l'école des sorciers" (id_livre = 3)
INSERT INTO exemplaire (etat, date_modification, id_status_exemplaire, id_livre)
VALUES
(TRUE, CURDATE(), 1, 3);


-- Les Misérables (id_livre = 1) : Drame, Aventure
INSERT INTO livre_genre (id_livre, id_genre)
VALUES (1, 2), (1, 6);

-- L'Étranger (id_livre = 2) : Philosophie ≠ genre → on peut mettre Drame par défaut
INSERT INTO livre_genre (id_livre, id_genre)
VALUES (2, 2);

-- Harry Potter à l'école des sorciers (id_livre = 3) : Fantastique, Aventure
INSERT INTO livre_genre (id_livre, id_genre)
VALUES (3, 4), (3, 6);

INSERT INTO type_utilisateur_droit (id_type_utilisateur, id_droit, type_acces)
VALUES 
  (1, 2, 4),
  (2, 2, 4),
  (3, 2, 1);

INSERT INTO type_utilisateur_droit (id_type_utilisateur, id_droit, type_acces)
VALUES 
  (1, 3, 4),
  (2, 3, 4),
  (3, 3, 1);

INSERT INTO type_utilisateur_droit (id_type_utilisateur, id_droit, type_acces)
VALUES 
  (1, 4, 4),
  (2, 4, 4),
  (3, 4, 1);

INSERT INTO type_utilisateur_droit (id_type_utilisateur, id_droit, type_acces)
VALUES 
  (1, 5, 4),
  (2, 5, 4),
  (3, 5, 1);

INSERT INTO type_utilisateur_droit (id_type_utilisateur, id_droit, type_acces)
VALUES 
  (1, 6, 4),
  (2, 6, 4),
  (3, 6, 1);

INSERT INTO status_pret (nom)
VALUES 
('En prolongement');

INSERT INTO status_demande(nom) VALUES ('En attente');
INSERT INTO status_demande(nom) VALUES ('Valider');
INSERT INTO status_demande(nom) VALUES ('Refuser');

INSERT INTO jour_ferier (date_ferier)
VALUES 
('2025-07-26'),
('2025-07-19');





