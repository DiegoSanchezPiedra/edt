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

CREATE OR REPLACE FUNCTION grau_perill(idprovatecnica int,idpacient int,resultat varchar)
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
$$
LANGUAGE 'plpgsql';
-------------------------------------------------------------------------------
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

CREATE OR REPLACE FUNCTION grau_perill(idprovatecnica int,idpacient int,resultat varchar)
RETURNS text AS
$$
DECLARE
    sql1 text := '';
    minpat text := '';
    maxpat text := '';
    minpan text := '';
    maxpan text := '';
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
    END LOOP;

    IF isnumeric(resultat) = FALSE
    THEN
        raise notice 'resultat alphanumeric';
        return resultat;
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

------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION grau_perill(idprovatecnica int,idpacient int,resultat varchar)
RETURNS text AS
$$
DECLARE
    sql1 text := '';
    minpat text := '';
    maxpat text := '';
    minpan text := '';
    maxpan text := '';
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
    END LOOP;

    IF registres.resultat_numeric 
    THEN
        IF resultat::INTEGER > maxpan::INTEGER or resultat::INTEGER < minpan::INTEGER
            THEN
                res := '3';
            ELSE 
                IF resultat::INTEGER > maxpat::INTEGER  or resultat::INTEGER < minpat::INTEGER
                THEN
                    res := '2';
                END IF;
            END IF;
    ELSE
        raise notice 'resultat alphanumeric';
        return resultat;
    END IF;
return res;
END;
$$
LANGUAGE 'plpgsql';

-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION grau_perill(idprovatecnica int,idpacient int,resultat varchar)
RETURNS text AS
$$
DECLARE
    sql1 text := '';
    minpat text := '';
    maxpat text := '';
    minpan text := '';
    maxpan text := '';
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
    END LOOP;

    IF registres.resultat_numeric 
    THEN
        IF resultat::INTEGER > maxpan::INTEGER or resultat::INTEGER < minpan::INTEGER
            THEN
                res := '3';
            ELSE 
                IF resultat::INTEGER > maxpat::INTEGER  or resultat::INTEGER < minpat::INTEGER
                THEN
                    res := '2';
                END IF;
            END IF;
    ELSE
        IF provestecnica.cadena_resultat != resultat
        THEN
            res := '2';
        END IF;
    END IF;
return res;
END;
$$
LANGUAGE 'plpgsql';