USE brawl;

LOAD DATA LOCAL INFILE '/home/usuari/compartida/BrawlStars-BBDD/personatges.csv' INTO TABLE rarezas
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, nom_rareza);

UPDATE rarezas
SET color = "Gris"
WHERE nom_rareza = "Comun";

UPDATE rarezas
SET color = "Verde"
WHERE nom_rareza = "Especial";

UPDATE rarezas
SET color = "Azul"
WHERE nom_rareza = "SuperEspecial";

UPDATE rarezas
SET color = "Morado"
WHERE nom_rareza = "Epico";

UPDATE rarezas
SET color = "Rojo"
WHERE nom_rareza = "Mitico";

UPDATE rarezas
SET color = "Amarillo"
WHERE nom_rareza = "Legendario";

LOAD DATA LOCAL INFILE '/home/usuari/compartida/BrawlStars-BBDD/personatges.csv' INTO TABLE tipus
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, nom_tipus);