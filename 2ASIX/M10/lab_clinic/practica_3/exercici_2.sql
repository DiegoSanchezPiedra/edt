CREATE OR REPLACE FUNCTION alarma(idprovatecnica int,idpacient int,resultat varchar(10))
RETURNS text AS
$$
DECLARE
minpat text := '';
maxpat text := '';
minpan text := '';
maxpan text := '';
res_maxpan record;
res text := '0';
BEGIN
    minpat := 'select minpat from provestecnica where idprovatecnica =' || idprovatecnica;
    
    maxpat := 'select maxpat from provestecnica where idprovatecnica =' || idprovatecnica;

    minpan := 'select minpan from provestecnica where idprovatecnica =' || idprovatecnica;

    maxpan := 'select maxpan from provestecnica where idprovatecnica =' || idprovatecnica;

    --resultats_prova := 'select resultats from resultats where idanalitica = 
    --(select idanalitica from analitiques where idpacient =' || idpacient || 'and iddoctor=' || iddoctor ')';
    EXECUTE(minpat);
    EXECUTE(maxpat);
    EXECUTE(minpan);

    raise notice 'resultat: %, maxpan: %',resultat,PERFORM(maxpan);
    IF resultat > maxpan THEN
        res := '1';
    END IF;
return res;
END;
$$
LANGUAGE 'plpgsql';


-------------------------------------------

CREATE OR REPLACE FUNCTION grau_perill(idprovatecnica int,idpacient int,resultat varchar(10))
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

    --raise notice 'resultat: %, maxpan: %',resultat,minpat;
    --raise notice 'resultat: %, maxpan: %',resultat,maxpat;
    --raise notice 'resultat: %, maxpan: %',resultat,minpan;
    --raise notice 'resultat: %, maxpan: %',resultat,maxpan;

    IF resultat > maxpan::INTEGER THEN
        res := '3';
        --raise notice 'panic: %, ',maxpan;
    ELSE 
        IF resultat < minpan::INTEGER THEN
            res := '3';
            --raise notice 'panic %',maxpan;
        ELSE
            IF resultat > maxpat::INTEGER THEN
                res := '2';
              --  raise notice 'patologic %',maxpat;
            ELSE
                IF resultat < minpat::INTEGER THEN
                    res := '2';
                --    raise notice 'patologic %',minpat;
                END IF;
            END IF;
        END IF;
    END IF;

return res;
END;
$$
LANGUAGE 'plpgsql';

----------------------------------------------------------------------------------

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

    --raise notice 'resultat: %, maxpan: %',resultat,minpat;
    --raise notice 'resultat: %, maxpan: %',resultat,maxpat;
    --raise notice 'resultat: %, maxpan: %',resultat,minpan;
    --raise notice 'resultat: %, maxpan: %',resultat,maxpan;
    EXECUTE (TO_NUMBER(resultat,'000000'));
    IF error
    THEN
        raise notice 'resultat alphanumeric';
        return resultat;
    ELSE
        IF resultat::INTEGER > maxpan::INTEGER 
        THEN
            res := '3';
            --raise notice 'panic: %, ',maxpan;
        ELSE 
            IF resultat::INTEGER < minpan::INTEGER 
            THEN
                res := '3';
                --raise notice 'panic %',maxpan;
            ELSE
                IF resultat::INTEGER > maxpat::INTEGER 
                THEN
                    res := '2';
                --  raise notice 'patologic %',maxpat;
                ELSE
                    IF resultat::INTEGER < minpat::INTEGER 
                    THEN
                        res := '2';
                    --    raise notice 'patologic %',minpat;
                    END IF;
                END IF;
            END IF;
        END IF;
    END IF;
return res;
END;
$$
LANGUAGE 'plpgsql';
