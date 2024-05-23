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

DROP TEMPORARY TABLE IF EXISTS temp_gadgets;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_gadgets (
    perso VARCHAR(24),
    nom_gadget VARCHAR(24),
    descripcio TEXT
);

LOAD DATA LOCAL INFILE '/home/usuari/gadget.csv' INTO TABLE temp_gadgets
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(perso, nom_gadget, descripcio);

DROP TEMPORARY TABLE IF EXISTS temp_habilidades_estelares;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_habilidades_estelares (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pers VARCHAR(24),
    nom VARCHAR(50),
    descripcio TEXT
);

LOAD DATA LOCAL INFILE '/home/usuari/habilitats_estelars.csv' INTO TABLE temp_habilidades_estelares
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(pers, nom, descripcio);

LOAD DATA LOCAL INFILE '/home/usuari/refuerzos.csv' INTO TABLE reforcos
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nom_ref, tipo, descripcio);

CREATE TEMPORARY TABLE IF NOT EXISTS temp_hipercargas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    perso VARCHAR(24),
    nom VARCHAR(50),
    descripcio TEXT
);

LOAD DATA LOCAL INFILE '/home/usuari/hipercargas.csv' INTO TABLE temp_hipercargas
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(perso, nom, descripcio);

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

INSERT INTO gadgets (id_pers, nom_gadget, descripcio)
SELECT p.id, tg.nom_gadget, tg.descripcio
FROM temp_gadgets tg
JOIN personatges p ON tg.perso = p.nom;

INSERT INTO habilitats_estelars (id_pers, nom_habest, descripcio)
SELECT p.id, he.nom, he.descripcio
FROM temp_habilidades_estelares he
JOIN personatges p ON he.pers = p.nom;

INSERT INTO hipercarga (id_pers, nom_hiper, descripcio)
SELECT p.id, hc.nom, hc.descripcio
FROM temp_hipercargas hc
JOIN personatges p ON hc.perso = p.nom;

DROP TEMPORARY TABLE IF EXISTS temp_nivel;
CREATE TEMPORARY TABLE IF NOT EXISTS temp_nivel (
    fuerza INT,
    nom_pers VARCHAR(24),
    vida INT,
    dany INT,
    PRIMARY KEY (fuerza, nom_pers)
);

LOAD DATA LOCAL INFILE '/home/usuari/nivel_brawl.csv' INTO TABLE temp_nivel
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(fuerza, nom_pers, vida, dany);

INSERT INTO forza_brawler (id_forza, id_pers, vida, dany)
SELECT fuerza, id, vida, dany FROM temp_nivel tn
JOIN personatges p ON tn.nom_pers = p.nom;

-- Aqui se ponen los update los gadget, refuerzos, hab estelares y hipercarga si tienen

-- Gadgets


UPDATE forza_brawler fb
SET id_gadget = (SELECT id_gadget FROM gadgets WHERE fb.id_pers = gadgets.id_pers ORDER BY RAND() LIMIT 1)
WHERE fb.id_forza >= 7;

-- Habilidad estelar
UPDATE forza_brawler fb
JOIN (
    SELECT id_habest, he.id_pers 
    FROM habilitats_estelars he
    ORDER BY RAND()
) he ON fb.id_pers = he.id_pers
SET fb.id_habest = he.id_habest
WHERE fb.id_forza >= 9;

-- Hipercarga
UPDATE forza_brawler fb
JOIN (
    SELECT id_hiper, id_pers 
    FROM hipercarga 
    ORDER BY RAND()
) hc ON fb.id_pers = hc.id_pers
SET fb.id_hiper = hc.id_hiper
WHERE fb.id_forza = 11;

-- Reforços
UPDATE forza_brawler fb
SET id_ref1 = 
    CASE 
        WHEN id_pers = 1 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 2 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 3 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 4 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 5 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 6 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 7 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 8 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 9 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 10 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 11 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 12 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 13 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 14 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 15 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 16 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 17 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 18 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 19 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 20 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 21 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 22 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 23 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 24 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 25 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
        WHEN id_pers = 26 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos ORDER BY RAND() LIMIT 1 ) AS refuerzos)
    END
WHERE id_forza >= 8;

UPDATE forza_brawler fb
SET id_ref2 = 
    CASE 
        WHEN id_pers = 1 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 1) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 2 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 2) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 3 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 3) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 4 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 4) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 5 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 5) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 6 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 6) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 7 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 7) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 8 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 8) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 9 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 9) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 10 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 11 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 11) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 12 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 12) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 13 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 13) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 14 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 14) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 15 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 15) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 16 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 16) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 17 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 17) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 18 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 18) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 19 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 19) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 20 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 20) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 21 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 21) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 22 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 22) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 23 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 23) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 24 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 24) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 25 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 25) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 26 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 26) ORDER BY RAND() LIMIT 1) AS refuerzos)
    END
WHERE id_forza >= 10;

-- Aqui acabn los update para los gadget, refuerzos, hab estelares y hipercarga si tienen