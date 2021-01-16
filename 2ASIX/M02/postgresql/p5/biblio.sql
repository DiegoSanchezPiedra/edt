-- Diego Alessandro Sanchez Piedra
-- isx2031424

--
-- PostgreSQL database dump
--

CREATE DATABASE biblioteca;

\c biblioteca

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
--name: autors
--
CREATE TABLE autors (
    "id_autor" smallint NOT NULL,
    "nom_autor" varchar(255) NOT NULL,
    "data_naixement" date,
    "pais_naixement" varchar(255),
    "pais_actual" varchar(255)
);

--
--name: obres
--
CREATE TABLE obres (
    "id_obra" smallint NOT NULL,
    "titol" varchar(255) NOT NULL UNIQUE,
    "idioma_original" varchar(255) NOT NULL,
    "any_escriptura" numeric(4,0) NOT NULL,
    "any_publicacio" numeric(4,0) NULL
);

--
--name: autors_obres
--

CREATE TABLE autors_obres (
    "id_obra" smallint NOT NULL,
    "id_autor" smallint NOT NULL
);

--
--alter table primay keys
--
ALTER TABLE autors
ADD PRIMARY KEY (id_autor);

ALTER TABLE obres
ADD PRIMARY KEY (id_obra);

ALTER TABLE autors_obres
ADD PRIMARY KEY (id_obra,id_autor);

--
--alter table foreign keys
--
ALTER TABLE autors_obres
ADD FOREIGN KEY (id_autor) REFERENCES autors(id_autor),
ADD FOREIGN KEY (id_obra) REFERENCES obres(id_obra);
--
--name: edicions
--

CREATE TABLE edicions (
    "id_edicio" smallint NOT NULL,
    "id_obra" smallint NOT NULL,
    "data_edicio" date NOT NULL,
    "idioma" varchar(255) NOT NULL,
    "pais" varchar(255) NOT NULL
);

ALTER TABLE edicions
ADD PRIMARY KEY (id_edicio),
ADD FOREIGN KEY (id_obra) REFERENCES obres(id_obra);

--
--name: volums
--

CREATE TABLE volums (
    "id_volum" smallint NOT NULL,
    "n_volum" smallint NOT NULL,
    "id_edicio" smallint NOT NULL
);

ALTER TABLE volums
ADD PRIMARY KEY (id_volum),
ADD FOREIGN KEY (id_edicio) REFERENCES edicions(id_edicio);

--
--name:socis
--
CREATE TABLE socis (
    "id_soci" smallint NOT NULL,
    "nom_soci" character varying NOT NULL,
    "cognom_soci" character varying NOT NULL,
    "adre" character varying NOT NULL,
    "ciutat" character varying NOT NULL,
    "DNI" varchar(9) CHECK length(DNI) = 9 UNIQUE, --no te NOT NULL els nens petits que no tenen dni 
    "data_naixement" date NOT NULL,
    "sexe" character varying NOT NULL
);

--
--name: exemplars
--
CREATE TABLE exemplars (
    "num_referencia" smallint NOT NULL,
    "num_exemplar" smallint NOT NULL,
    "id_volum" SMALLINT NOT NULL
);
--
--name: prestec
--

CREATE TABLE prestec (
    "num_referencia" smallint NOT NULL,
    "id_soci" smallint NOT NULL ,
    "estat" character varying NOT NULL,
    "data_demanda" date NOT NULL,
    "data_retorn" date
);

ALTER TABLE socis
ADD PRIMARY KEY (id_soci);

ALTER TABLE exemplars
ADD PRIMARY KEY (num_referencia),
ADD FOREIGN KEY (id_volum) REFERENCES volums(id_volum);

ALTER TABLE prestec
ADD PRIMARY KEY (num_referencia,id_soci),
ADD FOREIGN KEY (num_referencia) REFERENCES exemplars(num_referencia),
ADD FOREIGN KEY (id_soci) REFERENCES socis(id_soci);

--
--name: tema
--

CREATE TABLE tema (
    "id_tema" smallint NOT NULL,
    "nom_tema" character varying NOT NULL,
    "descripcio" character varying NOT NULL
);

--
--name: subtema
--
CREATE TABLE subtema (
    "id_tema" smallint NOT NULL,
    "id_tema_mare" smallint NOT NULL
);

--
--name: obres_temas
--
CREATE TABLE obres_temas (
    "id_obra" smallint NOT NULL,
    "id_tema" smallint NOT NULL
);

--
-- alter table primary keys
---

ALTER TABLE tema
ADD PRIMARY KEY (id_tema);

ALTER TABLE subtema
ADD PRIMARY KEY (id_tema,id_tema_mare);

ALTER TABLE obres_temas
ADD PRIMARY KEY (id_obra,id_tema);

--
-- alter table foreign keys
--

ALTER TABLE subtema
ADD FOREIGN KEY (id_tema) REFERENCES tema(id_tema),
ADD FOREIGN KEY (id_tema_mare) REFERENCES tema(id_tema);

ALTER TABLE obres_temas
ADD FOREIGN KEY (id_obra) REFERENCES obres(id_obra),
ADD FOREIGN KEY (id_tema) REFERENCES tema(id_tema);
