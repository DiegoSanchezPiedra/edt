--Diego Sanchez Piedra
--isx2031424
CREATE TABLE resultats_repetits(
    idresultat int NOT NULL,
    repeticio int NOT NULL,
    idanalitica int NOT NULL,
    idprovatecnica int NOT NULL,
    resultat varchar(255) NOT NULL,
    dataresultat TIMESTAMP NOT NULL
);
ALTER TABLE resultats_repetits 
ADD PRIMARY KEY (idresultat,repeticio),
ADD FOREIGN KEY (idresultat) REFERENCES resultats(idresultat),
ADD FOREIGN KEY (idanalitica) REFERENCES analitiques(idanalitica);

--ALTER TABLE resultats_repetits
--ADD FOREIGN KEY (idprovatecnica) REFERENCES provestecnica(idprovatecnica);
--no em deixa posar aquesta clau forana, em dona aquest error des de l'examen passat:
--ERROR:  there is no unique constraint matching given keys for referenced table "provestecnica"