CREATE DATABASE stock_logistica;

\c stock_logistica

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--taula camions
CREATE TABLE camions(
    "id_camio" serial NOT NULL
);

ALTER TABLE camions
ADD PRIMARY KEY (id_camio);

--taula transportistes
CREATE TABLE transportistes(
    "id_transportista" serial NOT NULL,
    "nom_transportista" varchar(255) NOT NULL,
    "cognom_transportista" varchar(255) NOT NULL
);

ALTER TABLE transportistes
ADD PRIMARY KEY(id_transportista);

--taula productes
CREATE TABLE productes(
    "id_producte" serial NOT NULL
);

ALTER TABLE productes
ADD PRIMARY KEY (id_producte);

--taula magatzems
CREATE TABLE magatzems(
    "id_magatzem" serial NOT NULL
);

ALTER TABLE magatzems
ADD PRIMARY KEY (id_magatzem);

--taula stock (relacio magatzems-productes)
CREATE TABLE stock(
    "id_stock" serial NOT NULL,
    "id_producte" int NOT NULL,
    "id_magatzem" int NOT NULL,
    "quantitat_producte" int NOT NULL
);

ALTER TABLE stock
ADD PRIMARY KEY (id_stock),
ADD FOREIGN KEY(id_magatzem) REFERENCES magatzems(id_magatzem),
ADD UNIQUE (id_producte,id_magatzem);

--taula transports
CREATE TABLE transports(
    "id_transport" serial NOT NULL,
    "id_camio" int NOT NULL,
    "id_transportista" int NOT NULL
);

ALTER TABLE transports
ADD PRIMARY KEY(id_transport),
ADD FOREIGN KEY(id_camio) REFERENCES camions(id_camio),
ADD FOREIGN KEY (id_transportista) REFERENCES transportistes(id_transportista);

--tula porcions
CREATE TABLE porcions(
    "id_porcio" serial NOT NULL,
    "id_linia_comanda" int NOT NULL,
    "id_transport" int NOT NULL,
    "id_magatzem" int NOT NULL,
    "quantitat" int NOT NULL,
    "status" varchar(255) NOT NULL,
    "data_recollida" date NOT NULL,
    "hora_recollida" TIME (0) NOT NULL,
    "data_entrega" date NOT NULL,
    "hora_entrega" TIME (0) NOT NULL
);

ALTER TABLE porcions
ADD PRIMARY KEY (id_porcio),
ADD FOREIGN KEY (id_transport) REFERENCES transports(id_transport),
ADD FOREIGN KEY (id_magatzem) REFERENCES magatzems(id_magatzem),
ADD UNIQUE (id_linia_comanda,id_transport,id_magatzem);