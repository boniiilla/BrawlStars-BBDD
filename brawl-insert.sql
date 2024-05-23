USE brawl;

LOAD DATA LOCAL INFILE '/home/usuari/compartida/BrawlStars-BBDD/rarezas.csv' INTO TABLE rarezas
FIELDS TERMINATED BY '\t' ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
(nom_rareza, color);