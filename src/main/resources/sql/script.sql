CREATE DATABASE bibliotheque;

\c bibliotheque;

CREATE TABLE type_utilisateur(
   id_type_utilisateur SERIAL,
   nom VARCHAR(50) NOT NULL,
   description VARCHAR(250),
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   PRIMARY KEY(id_type_utilisateur),
   UNIQUE(nom)
);

INSERT INTO type_utilisateur (nom, description, etat, date_modification) VALUES ('Sena', 'Etudiant', 'TRUE', '2025-5-12');

CREATE TABLE droit(
   id_droit SERIAL,
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_droit),
   UNIQUE(nom)
);

CREATE TABLE personnel(
   id_personnel SERIAL,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   email VARCHAR(100) NOT NULL,
   contact SMALLINT,
   mot_de_passe VARCHAR(100) NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   id_type_utilisateur INTEGER NOT NULL,
   PRIMARY KEY(id_personnel),
   UNIQUE(email),
   FOREIGN KEY(id_type_utilisateur) REFERENCES type_utilisateur(id_type_utilisateur)
);

CREATE TABLE type_adherant(
   id_type_adherant SERIAL,
   nom VARCHAR(50) NOT NULL,
   description VARCHAR(100),
   limite_emprunt SMALLINT,
   duree_max_pret SMALLINT,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   PRIMARY KEY(id_type_adherant),
   UNIQUE(nom)
);

CREATE TABLE adherant(
   id_adherant SERIAL,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   email VARCHAR(50) NOT NULL,
   contact SMALLINT NOT NULL,
   adresse VARCHAR(50),
   photo VARCHAR(50),
   activite BOOLEAN NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   id_type_utilisateur INTEGER NOT NULL,
   id_type_adherant INTEGER NOT NULL,
   PRIMARY KEY(id_adherant),
   UNIQUE(email),
   FOREIGN KEY(id_type_utilisateur) REFERENCES type_utilisateur(id_type_utilisateur),
   FOREIGN KEY(id_type_adherant) REFERENCES type_adherant(id_type_adherant)
);

CREATE TABLE type_de_pret(
   id_type_de_pret SERIAL,
   nom VARCHAR(50) NOT NULL,
   duree_max_pret_jour SMALLINT,
   duree_max_pret_heure NUMERIC(10,2),
   montant_penalite INTEGER NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   PRIMARY KEY(id_type_de_pret),
   UNIQUE(nom)
);

CREATE TABLE livre(
   id_livre SERIAL,
   titre VARCHAR(50) NOT NULL,
   auteur VARCHAR(50) NOT NULL,
   editeur VARCHAR(50) NOT NULL,
   ISBN VARCHAR(50) NOT NULL,
   annee_publication DATE NOT NULL,
   genre_categorie VARCHAR(50) NOT NULL,
   nombre_exemplaire SMALLINT NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   PRIMARY KEY(id_livre),
   UNIQUE(titre),
   UNIQUE(ISBN)
);

CREATE TABLE exemplaire(
   id_exemplaire SERIAL,
   etat_livre BOOLEAN NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   id_livre INTEGER NOT NULL,
   PRIMARY KEY(id_exemplaire),
   FOREIGN KEY(id_livre) REFERENCES livre(id_livre)
);

CREATE TABLE status_pret(
   id_status_pret SERIAL,
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_status_pret),
   UNIQUE(nom)
);

CREATE TABLE status_penalite(
   id_status_penalite SERIAL,
   nom VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_status_penalite),
   UNIQUE(nom)
);

CREATE TABLE Pret(
   id_pret SERIAL,
   date_debut TIMESTAMP NOT NULL,
   date_fin_prevue TIMESTAMP NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   id_status_pret INTEGER NOT NULL,
   id_adherant INTEGER,
   id_personnel INTEGER,
   id_exemplaire INTEGER NOT NULL,
   id_type_de_pret INTEGER NOT NULL,
   PRIMARY KEY(id_pret),
   FOREIGN KEY(id_status_pret) REFERENCES status_pret(id_status_pret),
   FOREIGN KEY(id_adherant) REFERENCES adherant(id_adherant),
   FOREIGN KEY(id_personnel) REFERENCES personnel(id_personnel),
   FOREIGN KEY(id_exemplaire) REFERENCES exemplaire(id_exemplaire),
   FOREIGN KEY(id_type_de_pret) REFERENCES type_de_pret(id_type_de_pret)
);

CREATE TABLE penalite(
   id_penalite SERIAL,
   date_reelle_retour DATE NOT NULL,
   etat BOOLEAN NOT NULL,
   date_modification DATE NOT NULL,
   id_status_penalite INTEGER NOT NULL,
   id_pret INTEGER NOT NULL,
   PRIMARY KEY(id_penalite),
   FOREIGN KEY(id_status_penalite) REFERENCES status_penalite(id_status_penalite),
   FOREIGN KEY(id_pret) REFERENCES Pret(id_pret)
);

CREATE TABLE type_utilisatuer_droit(
   id_type_utilisateur INTEGER,
   id_droit INTEGER,
   PRIMARY KEY(id_type_utilisateur, id_droit),
   FOREIGN KEY(id_type_utilisateur) REFERENCES type_utilisateur(id_type_utilisateur),
   FOREIGN KEY(id_droit) REFERENCES droit(id_droit)
);

