CREATE DATABASE empresa;

\c empresa

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--taula provincies

CREATE TABLE provincies(
    "id_provincia" serial NOT NULL,
    "nom_provincia" varchar(255) NOT NULL
);


ALTER TABLE provincies
ADD PRIMARY KEY (id_provincia);

--taula ciutats

CREATE TABLE ciutats(
    "id_ciutat" serial NOT NULL,
    "id_provincia" int NOT NULL,
    "nom_ciutat" varchar(255) NOT NULL
);

ALTER TABLE ciutats
ADD PRIMARY KEY (id_ciutat),
ADD FOREIGN KEY (id_provincia) REFERENCES provincies(id_provincia);

--taula magatzems
CREATE TABLE magatzems(
    "id_magatzem" serial NOT NULL,
    "id_ciutat" int NOT NULL
);

ALTER TABLE magatzems
ADD PRIMARY KEY (id_magatzem),
ADD FOREIGN KEY (id_ciutat) REFERENCES ciutats(id_ciutat);

-- taula de productes i productes mare
CREATE TABLE productes(
    "id_producte" serial NOT NULL,
    "nom_producte" varchar(255) NOT NULL,
    "desc" text,
    "preu" int NOT NULL,
    "tipus_IVA" int NOT NULL
);

ALTER TABLE productes
ADD PRIMARY KEY (id_producte);

CREATE TABLE productes_mare(
    "id_producte" int NOT NULL,
    "id_produte_mare" int NOT NUll
);

ALTER TABLE productes_mare
ADD PRIMARY KEY (id_producte,id_produte_mare),
ADD FOREIGN KEY (id_producte) REFERENCES productes(id_producte),
ADD FOREIGN KEY (id_produte_mare) REFERENCES productes(id_producte);


--taula productes-magatzems
CREATE TABLE productes_magatzems(
    "id_producte" int NOT NULL,
    "id_magatzem" int NOT NULL
);

ALTER TABLE productes_magatzems
ADD PRIMARY KEY (id_producte,id_magatzem),
ADD FOREIGN KEY (id_producte) REFERENCES productes(id_producte),
ADD FOREIGN KEY (id_magatzem) REFERENCES magatzems(id_magatzem);
--taula venedors i supervisors

CREATE TABLE venedors( 
    "id_venedor" serial NOT NULL,
    "nom venedor" varchar(255) NOT NULL,
    "cognom_venedor" varchar(255) NOT NULL,
    "data_alta" date NOT NULL,
    "salari" int NOT NULL,
    "comisio" int NOT NULL,
    "id_ciutat" int NOT NULL
);

ALTER TABLE venedors
ADD PRIMARY KEY (id_venedor),
ADD FOREIGN KEY (id_ciutat) REFERENCES ciutats(id_ciutat);

CREATE TABLE supervisors(
    "id_venedor" int NOT NULL,
    "id_supervisor" int NOT NULL
);

ALTER TABLE supervisors
ADD PRIMARY KEY (id_venedor,id_supervisor),
ADD FOREIGN KEY (id_venedor) REFERENCES venedors(id_venedor),
ADD FOREIGN KEY (id_supervisor) REFERENCES venedors(id_venedor);

--taula clients

CREATE TABLE clients(
    "id_client" serial NOT NULL,
    "seu" varchar(255) NOT NULl,
    "adreça" varchar(255) NOT NULL,
    "nom_client" varchar(255) NOT NULL,
    "cognom_client" varchar(255) NOT NULL,
    "codi_postal" varchar(20) NOT NULL,
    "id_ciutat" int NOT NULL
);

ALTER TABLE clients
ADD PRIMARY KEY (id_client),
ADD FOREIGN KEY (id_ciutat) REFERENCES ciutats(id_ciutat);

-- taula comandes i linia comanda

CREATE TABLE comandes(
    "id_comanda" serial NOT NULL,
    "id_client" int NOT NULL,
    "data_comanda" date NOT NULL,
    "facturat" boolean NOT NULL,
    "num_comanda" int NOT NULL, --aquest nombre farà reset cada any perque va a hisenda
    "anyo" int NOT NULL --el mateix per hisenda
);

ALTER TABLE comandes
ADD PRIMARY KEY (id_comanda),
ADD FOREIGN KEY (id_client) REFERENCES clients(id_client),
ADD UNIQUE (num_comanda,anyo);

CREATE TABLE linia_comanda(
    "id_comanda" int NOT NULL,
    "id_venedor" int NOT NULL,
    "id_producte" int NOT NULl,
    "quantitat" int NOT NULL
);

ALTER TABLE linia_comanda
ADD PRIMARY KEY (id_comanda,id_producte),
ADD FOREIGN KEY (id_comanda) REFERENCES comandes(id_comanda),
ADD FOREIGN KEY (id_venedor) REFERENCES venedors(id_venedor),
ADD FOREIGN KEY (id_producte) REFERENCES productes(id_producte),
ADD UNIQUE (id_comanda,id_producte);