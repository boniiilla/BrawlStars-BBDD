USE brawl;

LOAD DATA LOCAL INFILE '/home/usuari/compartida/BrawlStars-BBDD/personatges.csv' INTO TABLE rarezas
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@dummy, @dummy, @dummy, @dummy, nom_rareza);