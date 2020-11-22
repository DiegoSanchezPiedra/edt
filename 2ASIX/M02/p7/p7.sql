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

--provincies

CREATE TABLE provincies(
    "id_provincia" serial NOT NULL,
    "nom_provincia" varchar(255) NOT NULL
);

--alter table provincia
ALTER TABLE provincies
ADD PRIMARY KEY (id_provincia);

--ciutats

CREATE TABLE ciutats(
    "id_ciutat" serial NOT NULL,
    "id_provincia" serial NOT NULL,
    "nom_ciutat" varchar(255) NOT NULL,
    "provincia" varchar(255) NOT NULL
);

--alter table ciutats
ALTER TABLE ciutats
ADD PRIMARY KEY (id_ciutat,id_provincia),
ADD FOREIGN KEY (id_provincia) REFERENCES provincies(id_provincia);

