USE brawl;

LOAD DATA LOCAL INFILE '/home/usuari/rarezas.csv' INTO TABLE rarezas
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nom_rareza, color);

LOAD DATA LOCAL INFILE '/home/usuari/tipus.csv' INTO TABLE tipus
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nom_tipus, descripcio);


DROP TEMPORARY TABLE IF EXISTS temp_pers;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_pers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(24),
    id_rareza INT,
    nom_rareza VARCHAR(24),
    id_tipus INT,
    nom_tipus VARCHAR(24),
    foto LONGBLOB,
    audio VARCHAR(64),
    descripcio TEXT
);

LOAD DATA LOCAL INFILE '/home/usuari/personatges.csv' INTO TABLE temp_pers
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nom, @dummy, @dummy, nom_tipus, nom_rareza, descripcio);

DROP TEMPORARY TABLE IF EXISTS temp_rare;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_rare (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_rareza INT
);

INSERT INTO temp_rare(id, id_rareza)
SELECT temp_pers.id, rarezas.id_rareza
  FROM temp_pers
  JOIN rarezas ON temp_pers.nom_rareza = rarezas.nom_rareza;

UPDATE temp_pers
SET id_rareza = (SELECT tr.id_rareza FROM temp_rare tr WHERE temp_pers.id = tr.id);

DROP TEMPORARY TABLE IF EXISTS temp_tip;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_tip (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_tipus INT
);

INSERT INTO temp_tip(id, id_tipus)
SELECT temp_pers.id, tipus.id_tipus
  FROM temp_pers
  JOIN tipus ON temp_pers.nom_tipus = tipus.nom_tipus;
 
UPDATE temp_pers
SET id_tipus = (SELECT tt.id_tipus FROM temp_tip tt WHERE temp_pers.id = tt.id);

INSERT INTO personatges(id, nom, id_rareza, id_tipus, descripcio)
SELECT id, nom, id_rareza, id_tipus, descripcio FROM temp_pers;

UPDATE personatges
SET foto = HEX(LOAD_FILE('/var/lib/mysql-files/shelly.jpeg'))
WHERE id = 1;

SELECT foto FROM personatges WHERE id = 1 INTO DUMPFILE '/tmp/shelly.jpeg';