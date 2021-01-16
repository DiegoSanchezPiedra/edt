CREATE DATABASE laboratori;

\c laboratori

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

CREATE TABLE pacients(
    id_pacient serial NOT NULL,
    nom varchar(255) NOT NULL,
    cognom varchar(255) NOT NULL,
    DNI varchar(9)
);

ALTER TABLE pacients
ADD PRIMARY KEY id_pacient;

CREATE TABLE analitica(
    id_analitica serial NOT NULL
);

ALTER TABLE analitica
ADD PRIMARY KEY id_analitica;

CREATE TABLE historial(
    id_historial serial NOT NULL,
    id_analitica int NOT NULL,
    id_pacient int NOT NULL,
    data_analitica date NOT NULL
);

ALTER TABLE historial
ADD PRIMARY KEY id_historial,
ADD FOREIGN KEY (id_analitica) REFERENCES analitica(id_analitica),
ADD FOREIGN KEY (id_pacient) REFERENCES pacients(id_pacient),
ADD UNIQUE (id_pacient,id_analitica);

CREATE TABLE resultats(
    id_resultat serial NOT NULL,
    id_historial int NOT NULL,
    resultat varchar(255),
    valor_referencia varchar(255)
);

ALTER TABLE resultats
ADD PRIMARY KEY (id_resultat),
ADD FOREIGN KEY id_historial REFERENCES historial(id_historial);

CREATE TABLE alarmes(
    id_alarma serial NOT NULL
);

ALTER TABLE alarmes
ADD PRIMARY KEY (id_alarma;)