--Diego Sanchez
--isx2031424
DROP DATABASE lab_clinic_1;
CREATE DATABASE lab_clinic_1;
\c lab_clinic_1;

CREATE TABLE pacients (
  idpacient serial PRIMARY KEY,
  nom varchar(15) NOT NULL,
  cognoms varchar(30) NOT NULL,
  dni varchar(9),
  data_naix date NOT NULL,
  sexe int NOT NULL,
  adreca varchar(50) NOT NULL,
  ciutat varchar(30) NOT NULL,
  c_postal varchar(10) NOT NULL,
  telefon varchar(9) NOT NULL,
  email varchar(30) NOT NULL,
  num_ss varchar(12) ,
  num_cat varchar(20) ,
  nie varchar(20),
  passaport varchar(20) 
);

CREATE TABLE doctors (
  iddoctor serial PRIMARY KEY,
  nom varchar(15) NOT NULL,
  cognoms varchar(30) NOT NULL,
  especialitat varchar(30) NOT NULL
);

CREATE TABLE analitiques (
  idanalitica serial PRIMARY KEY,
  iddoctor bigint ,
  idpacient bigint ,
  dataanalitica timestamp NOT NULL 
);

CREATE TABLE catalegproves (
  idprova int  PRIMARY KEY,
  nom_prova varchar(15) NOT NULL,
  descripcio varchar(100) NOT NULL,
  acronim varchar (15),
  info_autoritats boolean NOT NULL DEFAULT false
);

CREATE TABLE provestecnica (
  idprovatecnica serial,
  idprova int,
  sexe int NOT NULL,
  dataprova timestamp NOT NULL ,
  resultat_numeric boolean NOT NULL,
  minpat float NOT NULL,
  maxpat float NOT NULL,
  minpan float NOT NULL,
  maxpan float NOT NULL,
  resultat_cadena varchar(1) DEFAULT 'n',
  edatInicial int NOT NULL,
  edatFinal int NOT NULL
);

CREATE TABLE resultats (
  idresultat serial PRIMARY KEY,
  idanalitica bigint ,
  idprovatecnica bigint ,
  resultats varchar(10) NOT NULL,
  dataresultat timestamp NOT NULL,
  UNIQUE(idanalitica,idprovatecnica) 
);

CREATE TABLE alarmes (
  idalarma serial PRIMARY KEY,
  idresultat bigint ,
  nivellalama smallint NOT NULL,
  validat bool NOT NULL,
  missatge varchar(100) NOT NULL
);

CREATE TABLE resultats_patologics( 
  idresultat integer NOT NULL ,
  stamp timestamp NOT NULL, 
  userid text NOT NULL 
  );

/* taula logs */
CREATE TABLE logs(
  nom_usuari varchar(255) NOT NULL,
  data_operacio date NOT NULL,
  nom_taula varchar(255),
  operacio_realitzada varchar(255)
);
/* ALTERS*/


/*analitiques*/
ALTER TABLE analitiques
  ADD CONSTRAINT fk_idpacient FOREIGN KEY (idpacient) REFERENCES pacients (idpacient) ON UPDATE CASCADE,
  ADD CONSTRAINT fk_iddoctor FOREIGN KEY (iddoctor) REFERENCES doctors (iddoctor) ON UPDATE CASCADE;
  
/* provestecnica*/
ALTER TABLE provestecnica
  ADD CONSTRAINT fk_idprova FOREIGN KEY (idprova) REFERENCES catalegproves (idprova) ON UPDATE CASCADE,
  ADD PRIMARY KEY (idprovatecnica,sexe,edatInicial,edatFinal);
/* provestecnica amb sexe i edats
CREATE TABLE provestecnica (
  idprovatecnica serial,
  idprova int ,
  sexe int NOT NULL,
  edatini int NOT NULL,
  edatfi int NOT NULL,
  dataprova timestamp NOT NULL ,
  resultat_numeric boolean NOT NULL DEFAULT true,
  minpat float NOT NULL,
  maxpat float NOT NULL,
  minpan float NOT NULL,
  maxpan float NOT NULL,
  PRIMARY KEY (idprovatecnica, sexe, edatini)
);	

ALTER TABLE provestecnica
  ADD CONSTRAINT fk_idprova FOREIGN KEY (idprova) REFERENCES catalegproves (idprova) ON UPDATE CASCADE;  
*/

/*resultats*/
ALTER TABLE resultats
  ADD CONSTRAINT fk_idanalitica FOREIGN KEY (idanalitica) REFERENCES analitiques (idanalitica) ON UPDATE CASCADE;
  --ADD FOREIGN KEY (idprovatecnica) REFERENCES provestecnica (idprovatecnica) ;

--ALTER TABLE resultats_patologics
--  ADD CONSTRAINT fk_idresultat FOREIGN KEY (idresultat) REFERENCES resultats (idresultat) ON UPDATE CASCADE;
  
/* alarmes*/ 
ALTER TABLE alarmes
  ADD CONSTRAINT fk_idresultat FOREIGN KEY (idresultat) REFERENCES resultats (idresultat) ON UPDATE CASCADE;

/* INSERTS*/
INSERT INTO pacients (idpacient, nom, cognoms, dni, data_naix, sexe, adreca, ciutat, c_postal, telefon, email, num_ss, num_cat, nie, passaport) 
VALUES 
(default, 'Diego', 'Sanchez', '12345678A', '1999-01-01', 1, 'C/Urgell 187', 'Barcelona', '08036', '989856565', 'diego@edt.com', NULL, NULL, NULL, NULL),
(default, 'Mati', 'Vizcano', '12345678B', '1999-01-01', 2, 'C/Urgell 187', 'Barcelona', '08036', '989856563', 'mati@edt.com', NULL, NULL, NULL, NULL),
(default, 'Javier', 'Moyano', '12345678C', '1999-01-01', 1, 'C/Urgell 187', 'Barcelona', '08036', '989856562', 'javi@edt.com', NULL, NULL, NULL, NULL),
(default, 'Mark', 'Stanley', '12345678D', '1999-01-01', 1, 'C/Urgell 187', 'Barcelona', '08036', '989856561', 'mark@edt.com', NULL, NULL, NULL, NULL),
(default, 'Christian', 'Manalo', '12345678F', '1920-01-01', 1, 'C/Urgell 187', 'Barcelona', '08036', '989856568', 'christian@edt.com', NULL, NULL, NULL, NULL);

INSERT INTO doctors (iddoctor, nom, cognoms, especialitat) 
VALUES 
(default, 'Albert', 'Marinom', 'Cirugia'),
(default, 'Jose', 'Magarzo', 'Cirugia'),
(default, 'Miguel', 'Sanchez', 'Cardiologo'),
(default, 'Amelia', 'Carro', 'Cardiologo'),
(default, 'Didac', 'Nebreda', 'Dermatología'),
(default, 'Marisa', 'Pons', 'Fisioterapia'),
(default, 'Amelia', 'Carro', 'Cardiologo'),
(default, 'Beatriz', 'González', 'Ginecología'),
(default, 'Raúl', 'Campanario', 'Odontología'),
(default, 'Renzo', 'Remar', 'Fisioterapia');

INSERT INTO catalegproves (idprova, nom_prova, descripcio,acronim) 
VALUES 
(101, 'Glucosa', 'Es una hexosa',NULL),
(102, 'Potasio', 'Potasio','K'),
(82520, 'Cocaina', 'Prueba de cocaina', 'COAC'),
(103, 'Colesterol', 'Test colesterol nivell en sangre', 'COL'),
(104, 'Calcio', 'Prueba de calcio','CA');

INSERT INTO analitiques (idanalitica, iddoctor, idpacient, dataanalitica) 
VALUES 
(default, 1, 2, CURRENT_TIMESTAMP),
(default, 1, 1, CURRENT_TIMESTAMP),
(default, 2, 3, CURRENT_TIMESTAMP),
(default, 3, 4, CURRENT_TIMESTAMP),
(default, 4, 5, CURRENT_TIMESTAMP),
(default, 5, 3, CURRENT_TIMESTAMP),
(default, 2, 2, CURRENT_TIMESTAMP),
(default, 1, 3, CURRENT_TIMESTAMP),
(default, 2, 1, CURRENT_TIMESTAMP);


INSERT INTO provestecnica (idprovatecnica, idprova, sexe, dataprova,resultat_numeric, minpat, maxpat, minpan, maxpan,resultat_cadena,edatInicial,edatFinal) 
VALUES 
(DEFAULT, 101, 0, CURRENT_TIMESTAMP, 'True', '40', '90', '35', '85', 'n',0,999),
(DEFAULT, 101, 1, CURRENT_TIMESTAMP, 'True','20', '80', '35', '85', 'n',0,999),
(DEFAULT, 101, 2, CURRENT_TIMESTAMP, 'True','50', '80', '35', '85', 'n',0,999),
(DEFAULT, 82520, 1, CURRENT_TIMESTAMP, 'False', '0', '0', '0', '0', 'p',0,999),
(DEFAULT, 102, 1, CURRENT_TIMESTAMP, 'True','100', '200', '80', '120', 'n',0,50),
(DEFAULT, 102, 2, CURRENT_TIMESTAMP, 'True','400', '500', '380', '540', 'n',0,50),
(DEFAULT, 102, 1, CURRENT_TIMESTAMP, 'True','100', '200', '80', '120', 'n',51,100),
(DEFAULT, 102, 2, CURRENT_TIMESTAMP, 'True','400', '500', '380', '540', 'n',51,100)
;


/*
INSERT INTO provestecnica (idprovatecnica, idprova, sexe, dataprova, minpat, maxpat, minpan, maxpan) 
VALUES 
(default, '101', 'M', CURRENT_TIMESTAMP, '80', '100', '60', '150'),
(default, '101', 'F', CURRENT_TIMESTAMP, '70', '90', '50', '110'),
(default, '102', 'M', '2019-11-01 00:00:00', '111', '150', '80', '170'),
(default, '103', 'M', '2020-12-01 00:00:00', '80', '100', '60', '150'),
(default, '104', 'F', '2020-01-01 00:00:00', '70', '90', '50', '110'),
(default, '104', 'M', CURRENT_TIMESTAMP, '111', '150', '80', '170');
*/
INSERT INTO resultats (idresultat,idanalitica,idprovatecnica,resultats,dataresultat)
VALUES
(default,1,1,'160',CURRENT_TIMESTAMP),
(default,2,4,'p',CURRENT_TIMESTAMP),
(default,3,4,'n',CURRENT_TIMESTAMP),
(default,1,5,'90',CURRENT_TIMESTAMP),
(default,1,2,'180',CURRENT_TIMESTAMP),
(default,1,3,'90',CURRENT_TIMESTAMP);