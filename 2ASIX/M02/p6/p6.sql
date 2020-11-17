CREATE DATABASE bancs;

\c bancs

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--central sindical
CREATE TABLE central_sindical(
    "id_central" smallint NOT NULL,
    "nom_central" varchar(255) NOT NULL;
);

--alter table central sindical
ALTER TABLE central_sindical
ADD PRIMARY KEY (id_central);

--empleats
CREATE TABLE empleats (
    "id_empl" smallint NOT NULL,
    "nom_empl" varchar(255) NOT NULL,
    "congnom_empl" varchar(255) NOT NULL,
    "direccio" varchar(255) NOT NULL,
    "telefon" varchar(9),
    "data_naixement" date,
    "central_sindical" smallint NOT NULL
);

--alter table empleats
ALTER TABLE empleats
ADD PRIMARY KEY (id_empl),
ADD FOREIGN KEY (id_central) REFERENCES central_sindical(id_central);

-- excedencia
CREATE TABLE excedencia (
    "id_excendencia" smallint NOT NULL,
    "tipus_excedencia" varchar(255) NOT NULL
);

--alter table excendencia
ALTER TABLE excedencia
ADD PRIMARY KEY (id_excendencia);

-- excendencia-empleats
CREATE TABLE excedencia_empl (
    "id_empl" smallint NOT NULL,
    "id_excendencia" smallint NOT NULL,
    "data_excendencia" date NOT NULL, --data en la que es va demanar l'excedencia
    "data_final_excedencia" date 
);
-- alter table excendecia-empleats
ALTER TABLE excedencia_empl
ADD PRIMARY KEY (id_empl,id_excendencia,data_naixement),
ADD FOREIGN KEY (id_empl) REFERENCES empleats(id_empl),
ADD FOREIGN KEY (id_excendencia) REFERENCES excedencia(id_excendencia);

-- tipus prestecs
CREATE TABLE tipus_prestec (
    "id_tipus" smallint NOT NULL,
    "tipus_prestec" varchar NOT NULL
);

--alter table tipus prestec
ALTER TABLE tipus_prestec
ADD PRIMARY KEY (id_tipus);

-- prestecs
CREATE TABLE prestecs (
    "id_prestec" smallint NOT NULL,
    "id_empl" smallint NOT NULL,
    "data_prestec" date NOT NULL, -- data en la que es va demanar el prestec
    "id_tipus" smallint, 
    "causa" varchar(255)
);

--alter table prestecs
ALTER TABLE prestecs
ADD PRIMARY KEY (id_prestec,id_empl,data_prestec),
ADD FOREIGN KEY (id_empl) REFERENCES empleats(id_empl),
ADD FOREIGN KEY (id_tipus) REFERENCES tipus_prestec(id_tipus);

-- ciutats
CREATE TABLE ciutats (
    "id_ciutat" smallint NOT NULL,
    "nom_ciutat" varchar(255) NOT NULL,
    "pais" varchar(255) NOT NULL
);

--alter table ciutats

ALTER TABLE ciutats
ADD PRIMARY KEY (id_central,pais);

--titulacions academiques
CREATE TABLE titulacions_academiques (
    "id_titulacio" smallint NOT NULL,
    "nom_titol" varchar(255) NOT NULL
);

--alter table titulacion academiques
ALTER TABLE titulacions_academiques
ADD PRIMARY KEY (id_titulacio);

--CENTRES ACADEMICS
CREATE TABLE centres_academics (
    "id_centre" smallint NOT NULL,
    "nom_centre" varchar(255) NOT NULL,
    "id_ciutat" smallint NOT NULL,
    "pais" varchar(255) NOT NULL
);

--alter table centres academics
ALTER TABLE centres_academics
ADD PRIMARY KEY (id_centre,id_ciutat,pais),
ADD FOREIGN KEY (id_ciutat) REFERENCES ciutats(id_ciutat),
ADD FOREIGN KEY (pais) REFERENCES ciutats(pais);

-- EMPLEATS TITULACIO
CREATE TABLE empl_titulacio (
    "id_empl" smallint NOT NULL,
    "id_titulacio" smallint NOT NULL,
    "id_centre" smallint NOT NULL,
    "data_graduacio" date NOT NULL
);

--alter table empleats titulacio
ALTER TABLE empl_titulacio
ADD PRIMARY KEY (id_empl,id_titulacio,id_centre),
ADD FOREIGN KEY (id_empl) REFERENCES empleats(id_empl),
ADD FOREIGN KEY (id_titulacio) REFERENCES titulacions_academiques(id_titulacio),
ADD FOREIGN KEY (id_centre) REFERENCES centres_academics(id_centre);


--oficines

CREATE TABLE oficines (
    "id_oficina" smallint NOT NULL,
    "id_ciutat" smallint NOT NULL,
    "pais" varchar(255) NOT NULL
);

--alter table oficines
ALTER TABLE oficines
ADD PRIMARY KEY (id_oficina,id_oficina,pais),
ADD FOREIGN KEY (id_ciutat) REFERENCES ciutats(id_ciutat),
ADD FOREIGN KEY (pais) REFERENCES ciutats(pais);

-- empleat ciutat
CREATE TABLE empl_ciutat (
    "id_empl" smallint NOt NULL,
    "id_ciutat" smallint NOT NULL,
    "data" date NOT NULL --data en la qual l'empleat va esta en aqulla ciutat (historial)
);
