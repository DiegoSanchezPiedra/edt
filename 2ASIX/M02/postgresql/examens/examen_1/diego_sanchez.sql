CREATE DATABASE insta;

\c insta

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--taula usuaris
CREATE TABLE usuaris(
    "id_usuari" serial NOT NULL,
    "nickname" varchar(255) NOT NULL,
    "telefon" varchar(13) NOT NULL,
    "mail" varchar(255) NOT NULL,
    "ciutat" varchar(255) NOT NULL,
    "coordenades" varchar(255) NOT NULL,
    "clau_entrada" varchar(255) NOT NULL
);

ALTER TABLE usuaris
ADD PRIMARY KEY (id_usuari),
ADD UNIQUE (nickname);

--taula seguidors
CREATE TABLE seguidors(
    "id_seguidors" serial NOT NULL,
    "id_usuari" int NOT NULL,
    "id_seguidor" int NOT NULL
);

ALTER TABLE seguidors
ADD PRIMARY KEY (id_seguidors),
ADD FOREIGN KEY (id_usuari) REFERENCES usuaris(id_usuari),
ADD FOREIGN KEY (id_seguidor) REFERENCES usuaris(id_usuari),
ADD UNIQUE (id_usuari,id_seguidor);

--taula publicacions
CREATE TABLE publicacions(
    "id_pub" serial NOT NULL,
    "id_usuari" int NOT NULL, --usari qui ha publicat la pub
    "hora_pub" TIME (0) NOT NULL,
    "data_pub" date NOT NULL,
    "visible" boolean NOT NULL
);

ALTER TABLE publicacions
ADD PRIMARY KEY (id_pub),
ADD FOREIGN KEY (id_usuari) REFERENCES usuaris(id_usuari);


--taula rating
CREATE TABLE rating(
    "id_rate" serial NOT NULL,
    "id_pub" int NOT NULL,
    "id_usuari" int NOT NULL,
    "like" boolean NOT NULL
);

ALTER TABLE rating
ADD PRIMARY KEY (id_rate),
ADD FOREIGN kEY (id_pub) REFERENCES publicacions(id_pub),
ADD FOREIGN KEY (id_usuari) REFERENCES usuaris(id_usuari),
ADD UNIQUE (id_pub,id_usuari);