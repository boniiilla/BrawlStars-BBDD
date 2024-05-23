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

-- Shelly --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/shelly.jpeg')
WHERE id = 1;

SELECT foto FROM personatges WHERE id = 1 INTO DUMPFILE '/tmp/shelly.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/shelly.jpeg')),1,10))
WHERE id = 1;

-- Poco --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/poco.jpeg')
WHERE id = 2;

SELECT foto FROM personatges WHERE id = 2 INTO DUMPFILE '/tmp/poco.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/poco.jpeg')),1,10))
WHERE id = 2;

-- Primo --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/primo.jpeg')
WHERE id = 3;

SELECT foto FROM personatges WHERE id = 3 INTO DUMPFILE '/tmp/primo.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/primo.jpeg')),1,10))
WHERE id = 3;

-- Nita --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/nita.jpeg')
WHERE id = 4;

SELECT foto FROM personatges WHERE id = 4 INTO DUMPFILE '/tmp/nita.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/nita.jpeg')),1,10))
WHERE id = 4;

-- Bull --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/bull.jpeg')
WHERE id = 5;

SELECT foto FROM personatges WHERE id = 5 INTO DUMPFILE '/tmp/bull.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/bull.jpeg')),1,10))
WHERE id = 5;

-- Brock --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/brock.jpeg')
WHERE id = 6;

SELECT foto FROM personatges WHERE id = 6 INTO DUMPFILE '/tmp/brock.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/brock.jpeg')),1,10))
WHERE id = 6;

-- Dynamike --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/dynamyke.jpeg')
WHERE id = 7;

SELECT foto FROM personatges WHERE id = 7 INTO DUMPFILE '/tmp/dynamyke.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/dynamyke.jpeg')),1,10))
WHERE id = 7;

-- Tick --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/tick.jpeg')
WHERE id = 8;

SELECT foto FROM personatges WHERE id = 8 INTO DUMPFILE '/tmp/tick.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/tick.jpeg')),1,10))
WHERE id = 8;

-- 8-Bit --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/8-bit.jpeg')
WHERE id = 9;

SELECT foto FROM personatges WHERE id = 9 INTO DUMPFILE '/tmp/8-bit.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/8-bit.jpeg')),1,10))
WHERE id = 9;