# DATABASE FROM BRAWL STARS

Queremos crear una BBDD de nombre “brawl” para la gestión de personajes del videojuego Brawl Stars.

Nuestra base de datos estará centrada en la categorización, niveles y las diferentes habilidades que tiene cada personaje.

De cada personaje, que tendrá un identificador único, nos interesará conocer su nombre, foto del personaje, descripción, sonido, gadget(al nivel 7),refuerzos(1 primer refuerzo al llegar al nivel 8 y un segundo refuerzo al nivel 10) , habilidad estelar(al nivel 9), hipercarga(si es posible al nivel 11) y un nivel(máximo hasta 11).
Los personajes los clasificaremos según su tipo Destructor, Tiro de élite, Control, Asesino, Artillería, Tanque, o Apoyo y también según su rareza Común, Especial, Super Especial, Épico, Mitico, Legendario

De los tipos de personajes tendremos que saber su identificador único, tipo y su función dentro de las partidas.
La rareza, en general, también dispondrá un identificador único,nombre, una breve descripción y color de la rareza. Dado el caso, 1 personaje solo puede tener una rareza y un tipo, pero estos mismos se pueden aplicar a muchos personajes.

Los personajes irán subiendo de nivel, del 1 al 11 y según este mismo, aumentará la fuerza (puntos de daño) y los puntos de vida. Cabe destacar que cada personaje tiene su fuerza y puntos de vidas propios, no son globales para todos.

También se podrán obtener diversos gadgets, refuerzos, habilidades estelares y hipercargas (si el personaje puede tener) identificados por un ID, un nombre y una descripción de cada habilidad. En el caso de los gadgets, cada personaje tendrá la opción de elegir entre dos gadgets únicos una vez se llegue al nivel 7. Los refuerzos son globales, por eso mismo se compartirán entre todos los personajes una vez se llegue al nivel 8 y 10, y estos no se podrán repetir. Para las habilidades estelares también se podrán elegir entre dos únicas una vez se llegue al nivel 10. Para finalizar, las hipercargas hay personajes que las tendrán y se asignará ese valor, pero hay de otros que si no tienen se podrán cómo NULL. Es muy importante que cada personaje tendrá una hipercarga propia al llegar al nivel 11.


Brawler Comun: Shelly

Brawlers Especial: Poco, Primo, Nita, Bull, Brock

Brawlers SuperEspecial: Dinamyte, Tick, 8-Bit, Carl, Penny

Brawlers Epico: Edgar, Nani, Frank, Piper, Hank

Brawlers Mitico: Genio, Byron, Señor P, Squeak, Mico

Brawler Legendarios: Crow, Surge, Sandy, Kit, Leon