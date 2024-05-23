USE brawl;

-- LOADS DATA
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

-- INSERT PERSONATGES
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

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Shelly.m4a')
WHERE id = 1;

SELECT audio FROM personatges WHERE id = 1 INTO DUMPFILE '/tmp/shelly.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Shelly.m4a')),1,10))
WHERE id = 1;

-- Poco --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/poco.jpeg')
WHERE id = 2;

SELECT foto FROM personatges WHERE id = 2 INTO DUMPFILE '/tmp/poco.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/poco.jpeg')),1,10))
WHERE id = 2;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Poco.m4a')
WHERE id = 2;

SELECT audio FROM personatges WHERE id = 2 INTO DUMPFILE '/tmp/poco.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Poco.m4a')),1,10))
WHERE id = 2;

-- Primo --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/primo.jpeg')
WHERE id = 3;

SELECT foto FROM personatges WHERE id = 3 INTO DUMPFILE '/tmp/primo.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/primo.jpeg')),1,10))
WHERE id = 3;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Primo.m4a')
WHERE id = 3;

SELECT audio FROM personatges WHERE id = 3 INTO DUMPFILE '/tmp/primo.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Primo.m4a')),1,10))
WHERE id = 3;

-- Nita --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/nita.jpeg')
WHERE id = 4;

SELECT foto FROM personatges WHERE id = 4 INTO DUMPFILE '/tmp/nita.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/nita.jpeg')),1,10))
WHERE id = 4;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Nita.m4a')
WHERE id = 4;

SELECT audio FROM personatges WHERE id = 4 INTO DUMPFILE '/tmp/nita.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Nita.m4a')),1,10))
WHERE id = 4;

-- Bull --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/bull.jpeg')
WHERE id = 5;

SELECT foto FROM personatges WHERE id = 5 INTO DUMPFILE '/tmp/bull.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/bull.jpeg')),1,10))
WHERE id = 5;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Bull.m4a')
WHERE id = 5;

SELECT audio FROM personatges WHERE id = 5 INTO DUMPFILE '/tmp/bull.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Bull.m4a')),1,10))
WHERE id = 5;

-- Brock --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/brock.jpeg')
WHERE id = 6;

SELECT foto FROM personatges WHERE id = 6 INTO DUMPFILE '/tmp/brock.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/brock.jpeg')),1,10))
WHERE id = 6;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Brock.m4a')
WHERE id = 6;

SELECT audio FROM personatges WHERE id = 6 INTO DUMPFILE '/tmp/brock.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Brock.m4a')),1,10))
WHERE id = 6;

-- Dynamike --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/dinamyke.jpeg')
WHERE id = 7;

SELECT foto FROM personatges WHERE id = 7 INTO DUMPFILE '/tmp/dynamike.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/dinamyke.jpeg')),1,10))
WHERE id = 7;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Dinamyke.m4a')
WHERE id = 7;

SELECT audio FROM personatges WHERE id = 7 INTO DUMPFILE '/tmp/dynamike.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Dinamyke.m4a')),1,10))
WHERE id = 7;

-- Tick --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/tick.jpeg')
WHERE id = 8;

SELECT foto FROM personatges WHERE id = 8 INTO DUMPFILE '/tmp/tick.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/tick.jpeg')),1,10))
WHERE id = 8;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Tick.m4a')
WHERE id = 8;

SELECT audio FROM personatges WHERE id = 8 INTO DUMPFILE '/tmp/tick.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Tick.m4a')),1,10))
WHERE id = 8;

-- 8-Bit --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/8-bit.jpeg')
WHERE id = 9;

SELECT foto FROM personatges WHERE id = 9 INTO DUMPFILE '/tmp/8-bit.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/8-bit.jpeg')),1,10))
WHERE id = 9;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/8-Bit.m4a')
WHERE id = 9;

SELECT audio FROM personatges WHERE id = 9 INTO DUMPFILE '/tmp/8-Bit.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/8-Bit.m4a')),1,10))
WHERE id = 9;

-- Carl --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/carl.jpeg')
WHERE id = 10;

SELECT foto FROM personatges WHERE id = 10 INTO DUMPFILE '/tmp/carl.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/carl.jpeg')),1,10))
WHERE id = 10;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Carl.m4a')
WHERE id = 10;

SELECT audio FROM personatges WHERE id = 10 INTO DUMPFILE '/tmp/carl.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Carl.m4a')),1,10))
WHERE id = 10;

-- Penny --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/penny.jpeg')
WHERE id = 11;

SELECT foto FROM personatges WHERE id = 11 INTO DUMPFILE '/tmp/penny.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/penny.jpeg')),1,10))
WHERE id = 11;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Penny.m4a')
WHERE id = 11;

SELECT audio FROM personatges WHERE id = 11 INTO DUMPFILE '/tmp/penny.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Penny.m4a')),1,10))
WHERE id = 11;

-- Edgar --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/edgar.jpeg')
WHERE id = 12;

SELECT foto FROM personatges WHERE id = 12 INTO DUMPFILE '/tmp/edgar.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/edgar.jpeg')),1,10))
WHERE id = 12;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Edgar.m4a')
WHERE id = 12;

SELECT audio FROM personatges WHERE id = 12 INTO DUMPFILE '/tmp/edgar.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Edgar.m4a')),1,10))
WHERE id = 12;

-- Nani --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/nani.jpeg')
WHERE id = 13;

SELECT foto FROM personatges WHERE id = 13 INTO DUMPFILE '/tmp/nani.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/nani.jpeg')),1,10))
WHERE id = 13;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Nani.m4a')
WHERE id = 13;

SELECT audio FROM personatges WHERE id = 13 INTO DUMPFILE '/tmp/nani.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Nani.m4a')),1,10))
WHERE id = 13;

-- Frank --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/frank.jpeg')
WHERE id = 14;

SELECT foto FROM personatges WHERE id = 14 INTO DUMPFILE '/tmp/frank.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/frank.jpeg')),1,10))
WHERE id = 14;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Frank.m4a')
WHERE id = 14;

SELECT audio FROM personatges WHERE id = 14 INTO DUMPFILE '/tmp/frank.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Frank.m4a')),1,10))
WHERE id = 14;

-- Piper --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/piper.jpeg')
WHERE id = 15;

SELECT foto FROM personatges WHERE id = 15 INTO DUMPFILE '/tmp/piper.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/piper.jpeg')),1,10))
WHERE id = 15;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Piper.m4a')
WHERE id = 15;

SELECT audio FROM personatges WHERE id = 15 INTO DUMPFILE '/tmp/piper.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Piper.m4a')),1,10))
WHERE id = 15;

-- Hank --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/hank.jpeg')
WHERE id = 16;

SELECT foto FROM personatges WHERE id = 16 INTO DUMPFILE '/tmp/hank.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/hank.jpeg')),1,10))
WHERE id = 16;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Hank.m4a')
WHERE id = 16;

SELECT audio FROM personatges WHERE id = 16 INTO DUMPFILE '/tmp/hank.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Hank.m4a')),1,10))
WHERE id = 16;

-- Genio --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/genio.jpeg')
WHERE id = 17;

SELECT foto FROM personatges WHERE id = 17 INTO DUMPFILE '/tmp/genio.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/genio.jpeg')),1,10))
WHERE id = 17;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Genio.m4a')
WHERE id = 17;

SELECT audio FROM personatges WHERE id = 17 INTO DUMPFILE '/tmp/genio.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Genio.m4a')),1,10))
WHERE id = 17;

-- Byron --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/byron.jpeg')
WHERE id = 18;

SELECT foto FROM personatges WHERE id = 18 INTO DUMPFILE '/tmp/byron.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/byron.jpeg')),1,10))
WHERE id = 18;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Byron.m4a')
WHERE id = 18;

SELECT audio FROM personatges WHERE id = 18 INTO DUMPFILE '/tmp/byron.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Byron.m4a')),1,10))
WHERE id = 18;

-- Señor P --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/señorP.jpeg')
WHERE id = 19;

SELECT foto FROM personatges WHERE id = 19 INTO DUMPFILE '/tmp/señorP.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/señorP.jpeg')),1,10))
WHERE id = 19;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/SeñorP.m4a')
WHERE id = 19;

SELECT audio FROM personatges WHERE id = 19 INTO DUMPFILE '/tmp/señorp.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/SeñorP.m4a')),1,10))
WHERE id = 19;

-- Squeak --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/squeak.jpeg')
WHERE id = 20;

SELECT foto FROM personatges WHERE id = 20 INTO DUMPFILE '/tmp/squeak.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/squeak.jpeg')),1,10))
WHERE id = 20;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Squeak.m4a')
WHERE id = 20;

SELECT audio FROM personatges WHERE id = 20 INTO DUMPFILE '/tmp/squeak.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Squeak.m4a')),1,10))
WHERE id = 20;

-- Mico --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/mico.jpeg')
WHERE id = 21;

SELECT foto FROM personatges WHERE id = 21 INTO DUMPFILE '/tmp/mico.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/mico.jpeg')),1,10))
WHERE id = 21;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Mico.m4a')
WHERE id = 21;

SELECT audio FROM personatges WHERE id = 21 INTO DUMPFILE '/tmp/mico.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Mico.m4a')),1,10))
WHERE id = 21;

-- Crow --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/crow.jpeg')
WHERE id = 22;

SELECT foto FROM personatges WHERE id = 22 INTO DUMPFILE '/tmp/crow.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/crow.jpeg')),1,10))
WHERE id = 22;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Crowl.m4a')
WHERE id = 22;

SELECT audio FROM personatges WHERE id = 22 INTO DUMPFILE '/tmp/crow.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Crowl.m4a')),1,10))
WHERE id = 22;

-- Surge --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/surge.jpeg')
WHERE id = 23;

SELECT foto FROM personatges WHERE id = 23 INTO DUMPFILE '/tmp/surge.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/surge.jpeg')),1,10))
WHERE id = 23;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Surge.m4a')
WHERE id = 23;

SELECT audio FROM personatges WHERE id = 23 INTO DUMPFILE '/tmp/surge.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Surge.m4a')),1,10))
WHERE id = 23;

-- Sandy --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/sandy.jpeg')
WHERE id = 24;

SELECT foto FROM personatges WHERE id = 24 INTO DUMPFILE '/tmp/sandy.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/sandy.jpeg')),1,10))
WHERE id = 24;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Sandy.m4a')
WHERE id = 24;

SELECT audio FROM personatges WHERE id = 24 INTO DUMPFILE '/tmp/sandy.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Sandy.m4a')),1,10))
WHERE id = 24;

-- Kit --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/kit.jpeg')
WHERE id = 25;

SELECT foto FROM personatges WHERE id = 25 INTO DUMPFILE '/tmp/kit.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/kit.jpeg')),1,10))
WHERE id = 25;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Kit.m4a')
WHERE id = 25;

SELECT audio FROM personatges WHERE id = 25 INTO DUMPFILE '/tmp/kit.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Kit.m4a')),1,10))
WHERE id = 25;

-- Leon --
UPDATE personatges
SET foto = LOAD_FILE('/var/lib/mysql-files/leon.jpeg')
WHERE id = 26;

SELECT foto FROM personatges WHERE id = 26 INTO DUMPFILE '/tmp/leon.jpeg';

UPDATE personatges
SET foto = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/leon.jpeg')),1,10))
WHERE id = 26;

UPDATE personatges
SET audio = LOAD_FILE('/var/lib/mysql-files/Leon.m4a')
WHERE id = 26;

SELECT audio FROM personatges WHERE id = 26 INTO DUMPFILE '/tmp/leon.m4a';

UPDATE personatges
SET audio = UNHEX(SUBSTRING(HEX(LOAD_FILE('/var/lib/mysql-files/Leon.m4a')),1,10))
WHERE id = 26;

-- INSERTS GADGETS, HABILITAT_ESTELARS I HIPERCARGA
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
SET id_habest = (SELECT id_habest FROM habilitats_estelars WHERE fb.id_pers = habilitats_estelars.id_pers ORDER BY RAND() LIMIT 1)
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

UPDATE forza_brawler
SET id_ref2 = 
    CASE 
        WHEN id_pers = 1 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 1 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 2 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 2 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 3 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 3 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 4 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 4 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 5 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 5 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 6 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 6 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 7 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 7 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 8 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 8 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 9 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 9 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 10 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 10 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 11 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 11 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 12 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 12 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 13 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 13 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 14 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 14 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 15 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 15 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 16 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 16 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 17 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 17 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 18 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 18 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 19 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 19 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 20 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 20 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 21 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 21 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 22 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 22 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 23 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 23 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 24 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 24 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 25 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 25 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
        WHEN id_pers = 26 THEN (SELECT id_ref FROM (SELECT id_ref FROM reforcos WHERE id_ref NOT IN (
            SELECT id_ref1 FROM forza_brawler WHERE id_pers = 26 and id_forza >= 10) ORDER BY RAND() LIMIT 1) AS refuerzos)
    END
WHERE id_forza >= 10;

-- Aqui acabn los update para los gadget, refuerzos, hab estelares y hipercarga si tienen