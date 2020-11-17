--
-- DATABASE BANC
-- =============
-- Pràctica 6
-- Roberto Martínez
-- 15/11/2020
-- =============

--  TAULES:
--  ------
--	ciutats					(ID_ciutat, ciutat, provincia, pais)
--	oficines				(ID_oficina, adreca, telefon, ID_ciutat)
--	centres_sindicals		(ID_sindicat, nom_sindicat, telefon, email, quota)
--	empleats				(ID_empleat, nom, cognoms, telefon, email, ID_ciutat, ID_sindicat)
--	historials				(ID_empleat, ID_oficina, data_inici, data_final)
--	centres_academics		(ID_centre, nom_centre, adreca, telefon, ID_ciutat)
--	titulacions_academiques	(ID_titol, nom_titol, categoria)
--	hist_acad_empl			(ID_empleat, ID_centre, ID_titol)
--  categories_laborals		(ID_categoria, nom_categoria, sou, preu_h_extres, coeficient_SS)
--  empleats_categories		(ID_empleat, ID categoria, data_inici, data_final)
--  drets_excedencies		(ID_excedencia, descripcio, periode_dies)
--  empleats_excedencies	(ID_empleat, ID_excedencia, data_inici, data_final)
--  tipus_prestecs			(ID_tipus_prestec, descripcio, tipus_interes, periode_dies)
--	prestecs 				(ID_prestec, num_ref, data_inici, data_final, concedit, ID_tipus_prestec, ID_empleat)

CREATE DATABASE banc;

\c banc;

CREATE TABLE ciutats(
	ID_ciutat serial PRIMARY KEY,
	ciutat varchar(50) not null,
	provincia varchar(30) not null,
	pais varchar(30) not null
);

CREATE TABLE oficines(
	ID_oficina serial PRIMARY KEY,
	adreca varchar(100),
	telefon numeric(9,0) not null CHECK ( telefon >= 100000000 and telefon <= 999999999 ),
	ID_ciutat serial REFERENCES ciutats(ID_ciutat)
);

CREATE TABLE centres_sindicals(
	ID_sindicat serial PRIMARY KEY,
	nom_sindicat varchar(50) not null,
	telefon numeric(9,0) not null CHECK ( telefon >= 100000000 and telefon <= 999999999 ),
	email varchar(50) CHECK ( email LIKE '%@%'),
	quota numeric not null
);

CREATE TABLE empleats(
	ID_empleat serial PRIMARY KEY,
	nom varchar(30),
	cognoms varchar(60),
	telefon numeric(9,0) not null CHECK ( telefon >= 100000000 and telefon <= 999999999 ),
	email varchar(50) CHECK ( email LIKE '%@%'),
	ID_ciutat serial REFERENCES ciutats(ID_ciutat),
	ID_sindicat serial REFERENCES centres_sindicals(ID_sindicat)
);

CREATE TABLE historials(
	ID_empleat serial REFERENCES empleats(ID_empleat),
	ID_oficina serial REFERENCES oficines(ID_oficina),
	data_inici date not null DEFAULT current_date, 
	data_final date,
	PRIMARY KEY(ID_empleat, ID_oficina,data_inici)
);

CREATE TABLE centres_academics(
	ID_centre serial PRIMARY KEY,
	nom_centre varchar(40) not null,
	adreca varchar(100) not null,
	telefon numeric(9,0) not null CHECK ( telefon >= 100000000 and telefon <= 999999999 ),
	ID_ciutat serial not null REFERENCES ciutats(ID_ciutat)
);

CREATE TABLE titulacions_academiques(
	ID_titol serial PRIMARY KEY,
	nom_titol varchar(80) not null,
	categoria varchar(40)
);

CREATE TABLE hist_acad_empl(
	ID_empleat serial REFERENCES empleats(ID_empleat),
	ID_centre serial REFERENCES centres_academics(ID_centre),
	ID_titol serial REFERENCES titulacions_academiques(ID_titol),
	PRIMARY KEY(ID_empleat, ID_centre, ID_titol)
);

CREATE TABLE categories_laborals(
	ID_categoria serial PRIMARY KEY,
	nom_categoria varchar(30) not null,
	sou smallint not null CHECK ( sou > 0 ),
	preu_h_extres smallint not null CHECK ( preu_h_extres > 0 ),
	coeficient_SS smallint not null CHECK ( coeficient_SS >= 0 and coeficient_SS <= 100 )
);

CREATE TABLE empleats_categories(
	ID_empleat serial REFERENCES empleats(ID_empleat),
	ID_categoria serial REFERENCES categories_laborals(ID_categoria),
	data_inici date not null DEFAULT current_date,
	data_final date,
	PRIMARY KEY(ID_empleat, ID_categoria, data_inici)
);

CREATE TABLE drets_excedencies(
	ID_excedencia serial PRIMARY KEY,
	descripcio varchar(50) not null,
	periode_dies smallint CHECK ( periode_dies > 0 )
);

CREATE TABLE empleats_excedencies(
	ID_empleat serial REFERENCES empleats(ID_empleat),
	ID_excedencia serial REFERENCES drets_excedencies(ID_excedencia),
	data_inici date not null DEFAULT current_date,
	data_final date,
	PRIMARY KEY(ID_empleat, ID_excedencia, data_inici)
);

CREATE TABLE tipus_prestecs(
	ID_tipus_prestec serial PRIMARY KEY,
	descripcio varchar(30) not null,
	tipus_interes varchar(15) not null,
	periode_dies smallint not null CHECK ( periode_dies > 0 )
);

CREATE TABLE prestecs(
	ID_prestec serial PRIMARY KEY,
	num_ref varchar(30) UNIQUE,
	data_inici date DEFAULT current_date,
	data_final date,
	concedit boolean not null,
	ID_tipus_prestec serial REFERENCES tipus_prestecs(ID_tipus_prestec),
	ID_empleat serial REFERENCES empleats(ID_empleat),
	UNIQUE(data_inici, ID_empleat, ID_tipus_prestec)
);

-- TEST INTEGRITAT REFERENCIAL
-- ===========================
-- ciutats				   (ID_ciutat, ciutat, provincia, pais)
INSERT INTO ciutats VALUES (1001, 'Barcelona', 'Barcelona', 'Espanya');
INSERT INTO ciutats VALUES (1002, 'Girona', 'Girona', 'Espanya');

-- oficines				    (ID_oficina, adreca, telefon, ID_ciutat)
INSERT INTO oficines VALUES (2001, 'Carrer Aragó 376, baixos A', 934662179, 1001);
INSERT INTO oficines VALUES (2002, 'Passeig Lluís Companys 16 local', 937689178, 1001);
INSERT INTO oficines VALUES (2003, 'Carrer de Dalt 3, local', 936368917, 1002);

-- error oficines
INSERT INTO oficines VALUES (2004, 'Passeig Marítim 124 baixos', 973558961, 1007);
-- ERROR:  insert or update on table "oficines" violates foreign key constraint "oficines_id_ciutat_fkey"
-- DETAIL:  Key (id_ciutat)=(1007) is not present in table "ciutats".

-- centres_sindicals		 		 (ID_sindicat, nom_sindicat, telefon, email, quota)
INSERT INTO centres_sindicals VALUES (3001, 'Confederació General del Treball', 931236548, 'cgt@cat', 60);
INSERT INTO centres_sindicals VALUES (3002, 'Comisions Obreres', 938529177, 'ccoo@cat', 120);

-- empleats				    (ID_empleat, nom, cognoms, telefon, email, ID_ciutat, ID_sindicat)
INSERT INTO empleats VALUES (4001, 'Josep', 'Arnau i Sàez', 606785200, 'jfs45@gmail.com', 1002, 3001);
INSERT INTO empleats VALUES (4002, 'Marta', 'Torres Martín', 689722060, 'martatomall@gmail.com', 1002, 3002);
INSERT INTO empleats VALUES (4003, 'Anna', 'Ribes i Ferrer', 606785200, 'anrife@gmail.com', 1001, 3001);
-- errors empleats
INSERT INTO empleats VALUES (4004, 'Anna', 'Ribes i Ferrer', 606785200, 'anrife@gmail.com', 1001, 3025);
-- ERROR:  insert or update on table "empleats" violates foreign key constraint "empleats_id_sindicat_fkey"
-- DETAIL:  Key (id_sindicat)=(3025) is not present in table "centres_sindicals".
INSERT INTO empleats VALUES (4005, 'Anna', 'Ribes i Ferrer', 606785200, 'anrife@gmail.com', 1025, 3001);
-- ERROR:  insert or update on table "empleats" violates foreign key constraint "empleats_id_ciutat_fkey"
-- DETAIL:  Key (id_ciutat)=(1025) is not present in table "ciutats".

-- historials				  (ID_empleat, ID_oficina, data_inici, data_final)
INSERT INTO historials VALUES (4001, 2001, '2013-02-20', '2017-01-11');
INSERT INTO historials VALUES (4002, 2002, '2009-07-22', null);
INSERT INTO historials VALUES (4001, 2003, '2013-02-21', null);

-- errors historials
INSERT INTO historials VALUES (4009, 2001, '2013-02-20', '2017-01-11');
-- ERROR:  insert or update on table "historials" violates foreign key constraint "historials_id_empleat_fkey"
-- DETAIL:  Key (id_empleat)=(4009) is not present in table "empleats".
INSERT INTO historials VALUES (4001, 2009, '2013-02-20', '2017-01-11');
-- ERROR:  insert or update on table "historials" violates foreign key constraint "historials_id_oficina_fkey"
-- DETAIL:  Key (id_oficina)=(2009) is not present in table "oficines".

-- centres_academics		(ID_centre, nom_centre, adreca, telefon, ID_ciutat)
INSERT INTO centres_academics VALUES (5001, 'Escola del Treball', 'Carrer del Comte Urgell 187', 931123456, 1001);
INSERT INTO centres_academics VALUES (5002, 'Institut Jaume Balmes', 'Carrer de Casp 189', 938893571, 1001);
INSERT INTO centres_academics VALUES (5003, 'Universitat de Girona', 'Carrer de Casp 189', 948893271, 1002);
-- errors centres academics
INSERT INTO centres_academics VALUES (5001, 'Escola del Treball', 'Carrer del Comte Urgell, 187', 931023456, 1007);
-- ERROR:  duplicate key value violates unique constraint "centres_academics_pkey"
-- DETAIL:  Key (id_centre)=(5001) already exists.

-- titulacions_academiques	(ID_titol, nom_titol, categoria)
INSERT INTO titulacions_academiques VALUES (6001, 'Ciències Econom̀iques', 'Llicenciatura universitaria');
INSERT INTO titulacions_academiques VALUES (6002, 'Assitència a la direcció', 'FP Grau Superior');
INSERT INTO titulacions_academiques VALUES (6003, 'Administració de Sistemes Informàtics en Xarxa', 'FP Grau Superior');

-- hist_acad_empl				  (ID_empleat, ID_centre, ID_titol)
INSERT INTO hist_acad_empl VALUES (4002, 5003, 6001);
INSERT INTO hist_acad_empl VALUES (4001, 5001, 6002);
INSERT INTO hist_acad_empl VALUES (4001, 5001, 6003);
INSERT INTO hist_acad_empl VALUES (4003, 5002, 6001);
-- errors hist_acad_empl
INSERT INTO hist_acad_empl VALUES (4009, 5003, 6001);
-- ERROR:  insert or update on table "hist_acad_empl" violates foreign key constraint "hist_acad_empl_id_empleat_fkey"
-- DETAIL:  Key (id_empleat)=(4009) is not present in table "empleats".
INSERT INTO hist_acad_empl VALUES (4002, 5009, 6001);
-- ERROR:  insert or update on table "hist_acad_empl" violates foreign key constraint "hist_acad_empl_id_centre_fkey"
-- DETAIL:  Key (id_centre)=(5009) is not present in table "centres_academics"
INSERT INTO hist_acad_empl VALUES (4002, 5003, 6009);
-- ERROR:  insert or update on table "hist_acad_empl" violates foreign key constraint "hist_acad_empl_id_titol_fkey"
-- DETAIL:  Key (id_titol)=(6009) is not present in table "titulacions_academiques".

-- categories_laborals				   (ID_categoria, nom_categoria, sou, preu_h_extres, coeficient_SS)
INSERT INTO categories_laborals VALUES (7001, 'Ajudant de Direcció', 1689, 16.23, 17);
INSERT INTO categories_laborals VALUES (7002, 'Administratiu', 1422, 14.10, 14);
INSERT INTO categories_laborals VALUES (7003, 'Tècnic informàtic', 1506, 15.30, 14);

-- empleats_categories				   (ID_empleat, ID categoria, data_inici, data_final)
INSERT INTO empleats_categories VALUES (4001, 7002, '2013-11-11', '2015-06-09');
INSERT INTO empleats_categories VALUES (4001, 7003, '2015-06-10', null);
INSERT INTO empleats_categories VALUES (4002, 7003, '2010-07-25', '2019-01-08');
INSERT INTO empleats_categories VALUES (4003, 7001, '2010-07-25', null);
-- errors empleats_categories
INSERT INTO empleats_categories VALUES (4009, 7002, '2013-11-11', '2015-06-09');
-- ERROR:  insert or update on table "empleats_categories" violates foreign key constraint "empleats_categories_id_empleat_fkey"
-- DETAIL:  Key (id_empleat)=(4009) is not present in table "empleats".
INSERT INTO empleats_categories VALUES (4001, 7009, '2013-11-11', '2015-06-09');
-- ERROR:  insert or update on table "empleats_categories" violates foreign key constraint "empleats_categories_id_categoria_fkey"
-- DETAIL:  Key (id_categoria)=(7009) is not present in table "categories_laborals".

-- drets_excedencies		  (ID_excedencia, descripcio, periode_dies)
INSERT INTO drets_excedencies VALUES (0801, 'assitència a familiars', 365);
INSERT INTO drets_excedencies VALUES (0802, 'pactada', null);
INSERT INTO drets_excedencies VALUES (0803, 'voluntària', 142);

-- empleats_excedencies	        (ID_empleat, ID_excedencia, data_inici, data_final)
INSERT INTO empleats_excedencies VALUES (4001, 0801, '2006-01-01', '2007-01-01');
INSERT INTO empleats_excedencies VALUES (4001, 0801, '2009-01-01', '2010-01-01');
INSERT INTO empleats_excedencies VALUES (4002, 0801, '2014-07-15', '2015-07-15';
INSERT INTO empleats_excedencies VALUES (4002, 0802, '2019-12-12', null);
INSERT INTO empleats_excedencies VALUES (4003, 0803, '2008-12-01', '2019-04-05');
-- errors empleats_excedencies
INSERT INTO empleats_excedencies VALUES (4009, 0801, '2006-01-01', '2007-01-01');
-- ERROR:  insert or update on table "empleats_excedencies" violates foreign key constraint "empleats_excedencies_id_empleat_fkey"
-- DETAIL:  Key (id_empleat)=(4009) is not present in table "empleats".
INSERT INTO empleats_excedencies VALUES (4002, 0809, '2014-07-15', '2015-07-15');
-- ERROR:  insert or update on table "empleats_excedencies" violates foreign key constraint "empleats_excedencies_id_excedencia_fkey"
-- DETAIL:  Key (id_excedencia)=(809) is not present in table "drets_excedencies".

-- tipus_prestecs			(ID_tipus_prestec, descripcio, tipus_interes, periode_dies)
INSERT INTO tipus_prestecs VALUES (9001, 'prestec nomina', 'variable', 365);
INSERT INTO tipus_prestecs VALUES (9002, 'prestec hipoteca', '7.53% fixe', 7653);

-- prestecs 				(ID_prestec, num_ref, data_inici, data_final, concedit, ID_tipus_prestec, ID_empleat)
INSERT INTO prestecs VALUES (1101, 1550, '2015-01-20', '2016-01-20', true, 9001, 4001);
INSERT INTO prestecs VALUES (1111, 1650, '2018-08-28', null, false, 9001, 4001);
INSERT INTO prestecs VALUES (1112, 1555, '2015-01-22', '2019-11-28', true, 9002, 4001);
INSERT INTO prestecs VALUES (1122, 1750, '2015-10-02', null, false, 9002, 4003);
-- errors prestecs
INSERT INTO prestecs VALUES (1113, 2258, '2015-01-20', '2016-01-20', true, 9099, 4001);
-- ERROR:  insert or update on table "prestecs" violates foreign key constraint "prestecs_id_tipus_prestec_fkey"
-- DETAIL:  Key (id_tipus_prestec)=(9099) is not present in table "tipus_prestecs".
INSERT INTO prestecs VALUES (1189, 8890, '2015-01-20', '2016-01-20', true, 9001, 4099);
-- ERROR:  insert or update on table "prestecs" violates foreign key constraint "prestecs_id_empleat_fkey"
-- DETAIL:  Key (id_empleat)=(4099) is not present in table "empleats".
