--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: evaluar(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.evaluar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql1 text := '';
    reg record;
    id_pacient int := 0;
    grau_perill text := '';
BEGIN
    IF NEW.resultats = '' || NEW.resultats is NULL
    THEN
        return NEW;
    ELSE
        sql1 := 'select * from analitiques where idanalitica =' || NEW.idanalitica;
        FOR reg in EXECUTE(sql1)
        LOOP
            id_pacient := reg.idpacient;
        END LOOP;

        -- en cas que no hi hagi pacient no fem cap insert o update
        IF id_pacient = 0
        THEN
            RETURN NULL;
        END IF;

        --guardem el resultat del grau de perill
        grau_perill := grau_perill(NEW.idprovatecnica::int,id_pacient,NEW.resultats);

        IF grau_perill = '2' 
        or grau_perill = '3'
        THEN
            INSERT INTO resultats_patologics select NEW.idresultat , now() , user;
            RETURN NEW;
        ELSE
            IF grau_perill = '1'
            THEN
                RETURN NEW;
            END IF;
        END IF;
        RETURN NULL;
    END IF;
END;
$$;


--
-- Name: grau_perill(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.grau_perill(idprovatecnica integer, idpacient integer, resultat character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    sql1 text := '';
    minpat text := '';
    maxpat text := '';
    minpan text := '';
    maxpan text := '';
    resultat_cadena text := '';
    registres record;
    res text := '1';
BEGIN
    sql1 := 'select * from provestecnica where idprovatecnica=' || idprovatecnica;

    FOR registres in EXECUTE(sql1) 
    LOOP
        minpat := registres.minpat;
        maxpat := registres.maxpat;
        minpan := registres.minpan;
        maxpan := registres.maxpan;
        resultat_cadena := registres.resultat_cadena;
    END LOOP;

    IF isnumeric(resultat) = FALSE
    THEN
        IF resultat_cadena != resultat
        THEN
            res := '2';
        END IF;
    ELSE
        IF resultat::INTEGER > maxpan::INTEGER or resultat::INTEGER < minpan::INTEGER
        THEN
            res := '3';
        ELSE 
            IF resultat::INTEGER > maxpat::INTEGER  or resultat::INTEGER < minpat::INTEGER
            THEN
                res := '2';
            END IF;
        END IF;
    END IF;
return res;
END;
$$;


--
-- Name: isnumeric(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.isnumeric(cadena text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE 
    x NUMERIC;
BEGIN
    x = cadena::NUMERIC;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alarmes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alarmes (
    idalarma integer NOT NULL,
    idresultat bigint,
    nivellalama smallint NOT NULL,
    validat boolean NOT NULL,
    missatge character varying(100) NOT NULL
);


--
-- Name: alarmes_idalarma_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.alarmes_idalarma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: alarmes_idalarma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.alarmes_idalarma_seq OWNED BY public.alarmes.idalarma;


--
-- Name: analitiques; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analitiques (
    idanalitica integer NOT NULL,
    iddoctor bigint,
    idpacient bigint,
    dataanalitica timestamp without time zone NOT NULL
);


--
-- Name: analitiques_idanalitica_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analitiques_idanalitica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analitiques_idanalitica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analitiques_idanalitica_seq OWNED BY public.analitiques.idanalitica;


--
-- Name: catalegproves; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.catalegproves (
    idprova integer NOT NULL,
    nom_prova character varying(15) NOT NULL,
    descripcio character varying(100) NOT NULL,
    acronim character varying(15),
    info_autoritats boolean DEFAULT false NOT NULL
);


--
-- Name: doctors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctors (
    iddoctor integer NOT NULL,
    nom character varying(15) NOT NULL,
    cognoms character varying(30) NOT NULL,
    especialitat character varying(30) NOT NULL
);


--
-- Name: doctors_iddoctor_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.doctors_iddoctor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: doctors_iddoctor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.doctors_iddoctor_seq OWNED BY public.doctors.iddoctor;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logs (
    nom_usuari character varying(255) NOT NULL,
    data_operacio date NOT NULL,
    nom_taula character varying(255),
    operacio_realitzada character varying(255)
);


--
-- Name: pacients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pacients (
    idpacient integer NOT NULL,
    nom character varying(15) NOT NULL,
    cognoms character varying(30) NOT NULL,
    dni character varying(9),
    data_naix date NOT NULL,
    sexe character varying(1) NOT NULL,
    adreca character varying(50) NOT NULL,
    ciutat character varying(30) NOT NULL,
    c_postal character varying(10) NOT NULL,
    telefon character varying(9) NOT NULL,
    email character varying(30) NOT NULL,
    num_ss character varying(12),
    num_cat character varying(20),
    nie character varying(20),
    passaport character varying(20)
);


--
-- Name: pacients_idpacient_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pacients_idpacient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pacients_idpacient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pacients_idpacient_seq OWNED BY public.pacients.idpacient;


--
-- Name: provestecnica; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provestecnica (
    idprovatecnica integer NOT NULL,
    idprova integer,
    sexe integer NOT NULL,
    dataprova timestamp without time zone NOT NULL,
    resultat_numeric boolean DEFAULT true NOT NULL,
    minpat double precision NOT NULL,
    maxpat double precision NOT NULL,
    minpan double precision NOT NULL,
    maxpan double precision NOT NULL,
    resultat_cadena character varying(1) DEFAULT 'n'::character varying,
    edatinicial integer NOT NULL,
    edatfinal integer NOT NULL
);


--
-- Name: provestecnica_idprovatecnica_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.provestecnica_idprovatecnica_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: provestecnica_idprovatecnica_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.provestecnica_idprovatecnica_seq OWNED BY public.provestecnica.idprovatecnica;


--
-- Name: resultats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resultats (
    idresultat integer NOT NULL,
    idanalitica bigint,
    idprovatecnica bigint,
    resultats character varying(10) NOT NULL,
    dataresultat timestamp without time zone NOT NULL
);


--
-- Name: resultats_idresultat_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.resultats_idresultat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resultats_idresultat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.resultats_idresultat_seq OWNED BY public.resultats.idresultat;


--
-- Name: resultats_patologics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resultats_patologics (
    idresultat integer NOT NULL,
    stamp timestamp without time zone NOT NULL,
    userid text NOT NULL
);


--
-- Name: alarmes idalarma; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alarmes ALTER COLUMN idalarma SET DEFAULT nextval('public.alarmes_idalarma_seq'::regclass);


--
-- Name: analitiques idanalitica; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analitiques ALTER COLUMN idanalitica SET DEFAULT nextval('public.analitiques_idanalitica_seq'::regclass);


--
-- Name: doctors iddoctor; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctors ALTER COLUMN iddoctor SET DEFAULT nextval('public.doctors_iddoctor_seq'::regclass);


--
-- Name: pacients idpacient; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pacients ALTER COLUMN idpacient SET DEFAULT nextval('public.pacients_idpacient_seq'::regclass);


--
-- Name: provestecnica idprovatecnica; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provestecnica ALTER COLUMN idprovatecnica SET DEFAULT nextval('public.provestecnica_idprovatecnica_seq'::regclass);


--
-- Name: resultats idresultat; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resultats ALTER COLUMN idresultat SET DEFAULT nextval('public.resultats_idresultat_seq'::regclass);


--
-- Data for Name: alarmes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alarmes (idalarma, idresultat, nivellalama, validat, missatge) FROM stdin;
\.


--
-- Data for Name: analitiques; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.analitiques (idanalitica, iddoctor, idpacient, dataanalitica) FROM stdin;
1	1	2	2021-03-18 10:16:07.118226
2	1	1	2021-03-18 10:16:07.118226
3	2	3	2021-03-18 10:16:07.118226
4	3	4	2021-03-18 10:16:07.118226
5	4	5	2021-03-18 10:16:07.118226
6	5	3	2021-03-18 10:16:07.118226
7	2	2	2021-03-18 10:16:07.118226
8	1	3	2021-03-18 10:16:07.118226
9	2	1	2021-03-18 10:16:07.118226
\.


--
-- Data for Name: catalegproves; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.catalegproves (idprova, nom_prova, descripcio, acronim, info_autoritats) FROM stdin;
101	Glucosa	Es una hexosa	\N	f
102	Cocaina	Prueba de cocaina	COAC	f
103	Colesterol	Test colesterol nivell en sangre	COL	f
104	Calcio	Prueba de calcio	CA	f
\.


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.doctors (iddoctor, nom, cognoms, especialitat) FROM stdin;
1	Albert	Marinom	Cirugia
2	Jose	Magarzo	Cirugia
3	Miguel	Sanchez	Cardiologo
4	Amelia	Carro	Cardiologo
5	Didac	Nebreda	Dermatología
6	Marisa	Pons	Fisioterapia
7	Amelia	Carro	Cardiologo
8	Beatriz	González	Ginecología
9	Raúl	Campanario	Odontología
10	Renzo	Remar	Fisioterapia
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.logs (nom_usuari, data_operacio, nom_taula, operacio_realitzada) FROM stdin;
\.


--
-- Data for Name: pacients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.pacients (idpacient, nom, cognoms, dni, data_naix, sexe, adreca, ciutat, c_postal, telefon, email, num_ss, num_cat, nie, passaport) FROM stdin;
1	Diego	Sanchez	12345678A	1999-01-01	1	C/Urgell 187	Barcelona	08036	989856565	diego@edt.com	\N	\N	\N	\N
2	Mati	Vizcano	12345678B	1999-01-01	2	C/Urgell 187	Barcelona	08036	989856563	mati@edt.com	\N	\N	\N	\N
3	Javier	Moyano	12345678C	1999-01-01	1	C/Urgell 187	Barcelona	08036	989856562	javi@edt.com	\N	\N	\N	\N
4	Mark	Stanley	12345678D	1999-01-01	1	C/Urgell 187	Barcelona	08036	989856561	mark@edt.com	\N	\N	\N	\N
5	Christian	Manalo	12345678F	1920-01-01	1	C/Urgell 187	Barcelona	08036	989856568	christian@edt.com	\N	\N	\N	\N
\.


--
-- Data for Name: provestecnica; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.provestecnica (idprovatecnica, idprova, sexe, dataprova, resultat_numeric, minpat, maxpat, minpan, maxpan, resultat_cadena, edatinicial, edatfinal) FROM stdin;
1	101	0	2021-03-18 10:16:07.118915	t	40	90	35	85	n	0	999
2	101	1	2021-03-18 10:16:07.118915	t	20	80	35	85	n	0	999
3	101	2	2021-03-18 10:16:07.118915	t	50	80	35	85	n	0	999
4	102	1	2021-03-18 10:16:07.118915	t	100	200	80	120	n	0	50
5	102	2	2021-03-18 10:16:07.118915	t	400	500	380	540	n	0	50
6	102	1	2021-03-18 10:16:07.118915	t	100	200	80	120	n	51	100
7	102	2	2021-03-18 10:16:07.118915	t	400	500	380	540	n	51	100
\.


--
-- Data for Name: resultats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resultats (idresultat, idanalitica, idprovatecnica, resultats, dataresultat) FROM stdin;
9	1	1	160	2021-03-18 10:28:49.504559
10	2	4	p	2021-03-18 10:28:49.504559
11	3	4	n	2021-03-18 10:28:49.504559
12	1	5	90	2021-03-18 10:28:49.504559
13	1	2	180	2021-03-18 10:28:49.504559
14	1	3	90	2021-03-18 10:28:49.504559
\.


--
-- Data for Name: resultats_patologics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resultats_patologics (idresultat, stamp, userid) FROM stdin;
9	2021-03-18 10:28:49.504559	postgres
10	2021-03-18 10:28:49.504559	postgres
12	2021-03-18 10:28:49.504559	postgres
13	2021-03-18 10:28:49.504559	postgres
14	2021-03-18 10:28:49.504559	postgres
\.


--
-- Name: alarmes_idalarma_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.alarmes_idalarma_seq', 1, false);


--
-- Name: analitiques_idanalitica_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.analitiques_idanalitica_seq', 9, true);


--
-- Name: doctors_iddoctor_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.doctors_iddoctor_seq', 10, true);


--
-- Name: pacients_idpacient_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pacients_idpacient_seq', 5, true);


--
-- Name: provestecnica_idprovatecnica_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.provestecnica_idprovatecnica_seq', 7, true);


--
-- Name: resultats_idresultat_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.resultats_idresultat_seq', 14, true);


--
-- Name: alarmes alarmes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alarmes
    ADD CONSTRAINT alarmes_pkey PRIMARY KEY (idalarma);


--
-- Name: analitiques analitiques_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analitiques
    ADD CONSTRAINT analitiques_pkey PRIMARY KEY (idanalitica);


--
-- Name: catalegproves catalegproves_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.catalegproves
    ADD CONSTRAINT catalegproves_pkey PRIMARY KEY (idprova);


--
-- Name: doctors doctors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (iddoctor);


--
-- Name: pacients pacients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pacients
    ADD CONSTRAINT pacients_pkey PRIMARY KEY (idpacient);


--
-- Name: provestecnica provestecnica_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provestecnica
    ADD CONSTRAINT provestecnica_pkey PRIMARY KEY (idprovatecnica, sexe, edatinicial, edatfinal);


--
-- Name: resultats resultats_idanalitica_idprovatecnica_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resultats
    ADD CONSTRAINT resultats_idanalitica_idprovatecnica_key UNIQUE (idanalitica, idprovatecnica);


--
-- Name: resultats resultats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resultats
    ADD CONSTRAINT resultats_pkey PRIMARY KEY (idresultat);


--
-- Name: resultats in_evaluar; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER in_evaluar BEFORE INSERT OR UPDATE ON public.resultats FOR EACH ROW EXECUTE FUNCTION public.evaluar();


--
-- Name: analitiques fk_iddoctor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analitiques
    ADD CONSTRAINT fk_iddoctor FOREIGN KEY (iddoctor) REFERENCES public.doctors(iddoctor) ON UPDATE CASCADE;


--
-- Name: analitiques fk_idpacient; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analitiques
    ADD CONSTRAINT fk_idpacient FOREIGN KEY (idpacient) REFERENCES public.pacients(idpacient) ON UPDATE CASCADE;


--
-- Name: provestecnica fk_idprova; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provestecnica
    ADD CONSTRAINT fk_idprova FOREIGN KEY (idprova) REFERENCES public.catalegproves(idprova) ON UPDATE CASCADE;


--
-- Name: alarmes fk_idresultat; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alarmes
    ADD CONSTRAINT fk_idresultat FOREIGN KEY (idresultat) REFERENCES public.resultats(idresultat) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

