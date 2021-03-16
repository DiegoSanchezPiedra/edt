--Diego Sanchez
--isx2031424
CREATE OR REPLACE FUNCTION isnumeric(cadena text) 
RETURNS BOOLEAN AS 
$$
DECLARE 
    x NUMERIC;
BEGIN
    x = cadena::NUMERIC;
    RETURN TRUE;
EXCEPTION WHEN others THEN
    RETURN FALSE;
END;
$$
STRICT
LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION grau_perill(idprovatecnica int,idpacient int DEFAULT NULL,resultat varchar DEFAULT NULL)
RETURNS text AS
$$
DECLARE
    sql1 text := '';
    minpat text := '';
    maxpat text := '';
    minpan text := '';
    maxpan text := '';
    resultat_cadena text := '';
    registres record;
    res text := '1';
    naix text := '';
    edat int;
    existeix int := 0;
BEGIN
    -- si el pacient donat no existeix
    IF idpacient is NULL
    THEN
        return 2;
    ELSE
        sql1 = 'select * from pacients where idpacient=' || idpacient;
        FOR registres in EXECUTE(sql1)
        LOOP
            --si el sexe es NULL
            IF registres.sexe is NULL
            THEN
                return 2;
            END IF;
            --si la data de naixement es NULL
            IF registres.data_naix is NULL
            THEN
                return 2;
            END IF;
            --guardem les dades del pacient
            naix := registres.data_naix;
            sexe := registres.sexe;
            existeix := 1;
        END LOOP;
    END IF;

    IF existeix = 0
    THEN
        raise EXCEPTION 'el pacient: % no existeix', idpacient;
    END IF;
    
    --caulculem l'edat i la guardem
    sql1 := 'select extract (years from age(now(),' || quote_nullable(naix) || '))';
    FOR registres in EXECUTE(sql1)
    LOOP
        edat := registres.date_part;
    END LOOP;

    --calculem el nivell de perill que hi ha i el mostrem
    sql1 := 'select * from provestecnica where idprovatecnica=' || idprovatecnica || 
    'and (sexe =' || sexe ||' or sexe = 0) 
    and (' || edat || '>= edat_inical and ' || edat || '<= edat_final)';
    
    existeix := 0;
    FOR registres in EXECUTE(sql1) 
    LOOP
        minpat := registres.minpat;
        maxpat := registres.maxpat;
        minpan := registres.minpan;
        maxpan := registres.maxpan;
        resultat_cadena := registres.resultat_cadena;
        existeix := 1;
    END LOOP;
    
    --comprovar que la provatecnica existeix
    IF existeix = 0
    THEN
        return 2;
    END IF;

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
$$
LANGUAGE 'plpgsql';


----------------inserts de prova------------------
insert into pacients 
values(DEFAULT,'diego','sanchez piedra',NULL,'2000-03-17','evarist arnus 45','barcelona','08014','603389364','diego@di.com',NULL,NULL,'y2031424d',NULL,NULL);

insert into pacients
values(DEFAULT,'gabriel','sanchez piedra',NULL,NULL,'evarist arnus 45','barcelona','08014','603389364','diego@di.com',NULL,NULL,'y2031424d',NULL,1);

insert into pacients
values(DEFAULT,'joaquin','sanchez piedra',NULL,'2020-03-17','evarist arnus 45','barcelona','08014','603389364','joa@di.com',NULL,NULL,'y2031426d',NULL,1);

insert into pacients
values(4,'Amanda','sanchez piedra',NULL,'2020-03-17','evarist arnus 45','barcelona','08014','603389364','joa@di.com',NULL,NULL,'y2031426d',NULL,2);

insert into pacients
values(4,'Evi','sanchez piedra',NULL,'1996-07-12','evarist arnus 45','barcelona','08014','603389364','joa@di.com',NULL,NULL,'y2031426d',NULL,2);
--no hi ha pacient
lab_clinic=# select grau_perill(3,NULL,'19');
 grau_perill 
-------------
 2
(1 row)

--el sexe del pacient es null
lab_clinic=# select grau_perill(3,3,'19');
 grau_perill 
-------------
 2
(1 row)

--pacient amb sexe i data de naixement (masculí i 24 anys)
lab_clinic=# select grau_perill(3,1,'19');
 grau_perill 
-------------
 3
(1 row)

lab_clinic=# select grau_perill(3,1,'17');
 grau_perill 
-------------
 1
(1 row)

lab_clinic=# select grau_perill(3,1,'18');
 grau_perill 
-------------
 2
(1 row)

--pacient masculí amb 4 anys d'edat
lab_clinic=# select grau_perill(3,5,'18');
 grau_perill 
-------------
 3
(1 row)

--pacient femení amb 4 anys d'edat
lab_clinic=# select grau_perill(3,4,'18');
 grau_perill 
-------------
 1
(1 row)

--pacient fememí amb 24 anys d'edat
lab_clinic=# select grau_perill(3,6,'18');
 grau_perill 
-------------
 3
(1 row)

