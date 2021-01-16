CREATE TABLE casa_de_colonies (
    id_casa smallint NOT NULL,
    nom_casa character varying(20) NOT NULL,
    capacitat smallint NOT NULL,
);

CREATE TABLE infants (
    id_infant smallint NOT NULL,
    nom_infant character varying(20) NOT NULL,
    cognom_infant character varying(20) NOT NULL,
    tel_pare bigint,
    tel_mare bigint,
    comarca character varying(20) NOT NULL,
);

CREATE TABLE comarques (
    id_comarca smallint NOT NULL,
    nom_comarca character varying(2) NOT NULL,
    superficie smallint NOT NULL,
    n_habitants smallint NOT NULL,
);

CREATE TABLE activitats (
    id_activitat smallint,
    activitat character,
);

CREATE TABLE oferta_activitas (
    id_casa smallint NOT NULL,
    id_activitat smallint NOT NULL,
    fecha_qualificacio date NOT NULL,
    qualificacio smallint NOT NULL,
);

CREATE TABLE casa_infants (
    id_casa smallint NOT NULL,
    id_infant smallint NOT NULL,
    fecha_inscripcio date NOT NULL,
);

ALTER TABLE ONLY casa_de_colonies
    ADD CONSTRAINT casa_pkey PRIMARY KEY (id_casa);

ALTER TABLE ONLY infants
    ADD CONSTRAINT infants_pkey PRIMARY KEY (id_infant);

ALTER TABLE ONLY comarques
    ADD CONSTRAINT comarques_pkey PRIMARY KEY (id_comarca);

ALTER TABLE ONLY activitats
    ADD CONSTRAINT activitats_pkey PRIMARY KEY (id_activitat);

ALTER TABLE ONLY oferta_activitas
    ADD CONSTRAINT oferta_activitas_pky PRIMARY KEY (id_casa,id_activitat,fecha_qualificacio);

ALTER TABLE ONLY casa_infants
    ADD CONSTRAINT casa_infants_pkey PRIMARY KEY (id_casa,id_infant,fecha_inscripcio);
ALTER TABLE casa_infants
ADD FOREIGN KEY (comarca)
REFERENCES comarques(nom_comarca);

ALTER TABLE casa_infants
ADD FOREIGN KEY (id_casa)
REFERENCES casa_de_colonies(id_casa);

ALTER TABLE casa_infants
ADD FOREIGN KEY (id_infant)
REFERENCES infants(id_infant);

ALTER TABLE oferta_activitas
ADD FOREIGN KEY (id_casa)
REFERENCES casa_de_colonies(id_casa);

ALTER TABLE oferta_activitas
ADD FOREIGN KEY (id_activitat)
REFERENCES activitats(id_activitat);