drop DATABASE if exists gestor_mail;
CREATE DATABASE gestor_mail;
\c gestor_mail

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--taula adreçes
create table adreçes(
    id_adreça serial NOT NULL,
    adreça varchar(255) NOT NULL,
    nom varchar(255) NOT NULL
);

alter table adreçes
add primary key (id_adreça);

--taula adreçes grups
create table adreçes_grups(
    id_grups serial NOT NULL,
    id_adreça_grup int NOT NULL,
    id_adreça_usuari int NOT NULL
);

alter table adreçes_grups
add primary key (id_grups),
add unique (id_adreça_grup,id_adreça_usuari),
add foreign key (id_adreça_grup) references adreçes(id_adreça),
add foreign key (id_adreça_usuari) references adreçes(id_adreça);


--- taula missatges
create table missatges(
    id_missatge serial NOT NULL,
    emissor int NOT NULL,
    missatge text NOT NULL,
    esborrat boolean
);

alter table missatges
add primary key (id_missatge),
add foreign key (emissor) references adreçes(id_adreça);

create table missatges_adreçes(
    id_enviament serial NOT NULL,
    id_missatge int NOT NULL,
    receptor int NOT NULL,
    tipus_missatge varchar(255)
);

alter table missatges_adreçes
add primary key (id_enviament),
add unique (id_missatge,receptor),
add foreign key (id_missatge) references missatges(id_missatge),
add foreign key (receptor) references adreçes(id_adreça);