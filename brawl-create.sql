DROP DATABASE IF EXISTS brawl;
CREATE DATABASE IF NOT EXISTS brawl;

USE brawl;

CREATE TABLE rarezas (
    id_rareza INT AUTO_INCREMENT PRIMARY KEY,
    nom_rareza VARCHAR(24),
    color VARCHAR(24)
);

CREATE TABLE tipus (
    id_tipus INT AUTO_INCREMENT PRIMARY KEY,
    nom_tipus VARCHAR(36),
    descripcio TEXT
);

CREATE TABLE personatges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(24),
    id_rareza INT,
    id_tipus INT,
    foto LONGBLOB,
    audio VARCHAR(64),
    descripcio TEXT,
    FOREIGN KEY (id_rareza) REFERENCES rarezas(id_rareza),
    FOREIGN KEY (id_tipus) REFERENCES tipus(id_tipus)
);

CREATE TABLE gadgets (
    id_gadget INT AUTO_INCREMENT,
    id_pers INT,
    nom_gadget VARCHAR(24),
    descripcio TEXT,
    PRIMARY KEY(id_gadget, id_pers),
    FOREIGN KEY (id_pers) REFERENCES personatges(id)
);

CREATE TABLE reforcos (
    id_ref INT AUTO_INCREMENT PRIMARY KEY,
    nom_ref VARCHAR(24)
);

CREATE TABLE habilitats_estelars (
    id_habest INT AUTO_INCREMENT,
    id_pers INT,
    nom_habest VARCHAR(24),
    descripcio TEXT,
    PRIMARY KEY(id_habest, id_pers),
    FOREIGN KEY (id_pers) REFERENCES personatges(id)
);
