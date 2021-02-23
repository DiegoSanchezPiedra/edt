CREATE OR REPLACE FUNCTION resultats_analitica(id_pacient INT,id_analitica INT DEFAULT NULL)
RETURNS text AS
$$
DECLARE
    selected_row record;
    sql1 text := '';
    sql1_2 text := '';
    registres_1 record;
    sql2 text := '';
    sql3 text := '';
    sql4 text := '';
    registres record;
    registres_2 record;
    registres_3 record;
    registres_4 record;
    pacient text := '';
    data_analitica text := '';
    codi_prova text := '';
    nom_prova text := '';
    resultat text := '';
    id_provatecnica text := '';
    id_resultat text := '';
    valoracio text := '';
    res text := '';
BEGIN
    --mirem si el pacient donat existeix
    select * from pacients into selected_row where idpacient=id_pacient;
    IF not found 
    --si no existeix
    THEN
        raise notice 'error pacient: % no existeix',id_pacient;
        return '1';
    ELSE
        --si SI existeix
        IF id_analitica IS NULL
        THEN
            --si no s'ha donat el id de la anlitica
            select * from analitiques into selected_row where idpacient=id_pacient;
            IF not found
            THEN
                --si no hi ha cap analitica feta per el pacient donat
                raise notice 'ERROR analitica: % del pacient: % no existeix',id_analitica,id_pacient;
                return '1';
            ELSE
                --si si que hi ha analitica/ques feta/es per al pacient donat agafem la ultima feta i guardem el id_analitica
                sql1 := 'select * from analitiques where idpacient=' || id_pacient || 'order by dataanalitica desc limit 1';
                FOR registres_1 in EXECUTE(sql1)
                LOOP
                    id_analitica := registres_1.idanalitica;
                END LOOP;
                --raise notice 'id_analitica: %',id_analitica;
            END IF;
        ELSE
            --si l'analitica SI que s'ha donat
            select * from analitiques into selected_row where idanalitica=id_analitica;
            IF not found
            THEN
                --si l'analitica donada no existeix
                raise notice 'ERROR analitica: % no existeix',id_analitica;
                return '1';
            ELSE
                --si SI que hi és guardem la sentencia per executar-la deprés
                sql1 := 'select * from analitiques where idanalitica=' || id_analitica;
            END IF;
        END IF;
    END IF;

    FOR registres in EXECUTE(sql1)
    LOOP
        pacient := id_pacient;
        data_analitica := registres.dataanalitica;
        sql2 := 'SELECT * from catalegproves where idprova=
        (select idprova from provestecnica where idprovatecnica=
        (select idprovatecnica from resultats where idanalitica=' || id_analitica || '))';
        FOR registres_2 in EXECUTE(sql2)
        LOOP
            codi_prova := registres_2.idprova;
            --raise notice 'idprova: %',codi_prova;
            nom_prova := registres_2.nom_prova;
            --raise notice 'nom_prova: %',nom_prova;
        END LOOP;
        
        sql3 := 'SELECT * from provestecnica where idprova=' || codi_prova || 'limit 1';
        FOR registres_3 in EXECUTE(sql3)
        LOOP
            id_provatecnica := registres_3.idprovatecnica;
            --raise notice 'id_provatecnica: %',id_provatecnica;
        END LOOP;
        
        sql4 := 'SELECT * from resultats where idprovatecnica=' || id_provatecnica; 
        FOR registres_4 in EXECUTE(sql4)
        LOOP
            --raise notice 'id_provatecnica: %',id_provatecnica;
            resultat := registres_4.resultats;
            id_resultat := registres_4.idresultat;
            --raise notice 'id_resultat: %',id_resultat;
        END LOOP;
    END LOOP;
    res := pacient || ',' || data_analitica || ',' || codi_prova || ',' || nom_prova || ',' || resultat || ',' || resultats(id_resultat::int); 
    RETURN res;
END;
$$
LANGUAGE 'plpgsql';

----------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION resultats_analitica(id_pacient INT,id_analitica INT)
RETURNS text AS
$$
DECLARE
    selected_row record;
    sql1 text := '';
    sql2 text := '';
    sql3 text := '';
    sql4 text := '';
    registres record;
    registres_2 record;
    registres_3 record;
    registres_4 record;
    pacient text := '';
    data_analitica text := '';
    codi_prova text := '';
    nom_prova text := '';
    resultat text := '';
    id_provatecnica text := '';
    id_resultat text := '';
    valoracio text := '';
    res text := '';
BEGIN
    select * from pacients into selected_row where idpacient=id_pacient;
    IF not found 
    THEN
        raise notice 'error pacient: % no existeix',id_pacient;
        return '1';
    ELSE
        select * from analitiques into selected_row where idpacient=id_pacient;
        IF not found
        THEN
            raise notice 'ERROR analitica: % del pacient: % no existeix',id_analitica,id_pacient;
            return '1';
        ELSE
            select * from analitiques into selected_row where idanalitica=id_analitica;
            IF not found
            THEN
                raise notice 'ERROR analitica: % no existeix',id_analitica;
                return '1';
            ELSE
                sql1 := 'select * from analitiques where idanalitica=' || id_analitica;
            END IF;
        END IF;
    END IF;
    FOR registres in EXECUTE(sql1)
    LOOP
        pacient := id_pacient;
        data_analitica := registres.dataanalitica;
        sql2 := 'SELECT * from catalegproves where idprova=
        (select idprova from provestecnica where idprovatecnica=
        (select idprovatecnica from resultats where idanalitica=' || id_analitica || '))';
        FOR registres_2 in EXECUTE(sql2)
        LOOP
            codi_prova := registres_2.idprova;
            --raise notice 'idprova: %',codi_prova;
            nom_prova := registres_2.nom_prova;
            --raise notice 'nom_prova: %',nom_prova;
        END LOOP;
        
        sql3 := 'SELECT * from provestecnica where idprova=' || codi_prova || 'limit 1';
        FOR registres_3 in EXECUTE(sql3)
        LOOP
            id_provatecnica := registres_3.idprovatecnica;
            --raise notice 'id_provatecnica: %',id_provatecnica;
        END LOOP;
        
        sql4 := 'SELECT * from resultats where idprovatecnica=' || id_provatecnica; 
        FOR registres_4 in EXECUTE(sql4)
        LOOP
            --raise notice 'id_provatecnica: %',id_provatecnica;
            resultat := registres_4.resultats;
            id_resultat := registres_4.idresultat;
            --raise notice 'id_resultat: %',id_resultat;
        END LOOP;
    END LOOP;
    res := pacient || ',' || data_analitica || ',' || codi_prova || ',' || nom_prova || ',' || resultat || ',' || resultats(id_resultat::int); 
    RETURN res;
END;
$$
LANGUAGE 'plpgsql';

---------------------------------------------------
CREATE OR REPLACE FUNCTION resultats_analitica(id_pacient INT,id_analitica INT)
RETURNS text AS
$$
DECLARE
    selected_pacient pacients%rowtype;
    sql1 text := '';
    --count_existe int := '';
    --registres record;
    --pacient text := '';
    --data_analitica text := '';
    --codi_prova text := '';
    --nom_prova text := '';
    --resulat text := '';
    --valoracio text := '';
BEGIN
    select * from pacients into selected_pacient where idpacient=id_pacient;
    IF not found 
    THEN
        raise notice 'error pacient: % no existeix',id_pacient;
        return '1';
    ELSE
        IF id_analitica IS NULL
        THEN
            select * from analitiques into selected_pacient where idpacient=id_pacient;
            IF not found
            THEN
                raise notice 'error analitica: % del pacient:% no existeix',id_analitica,id_pacient;
                return '1';
            ELSE
                sql1 := 'select * from analitiques order by dataanalitica limit 1';
            END IF;
        ELSE
            select * from analitiques into selected_pacient where idanalitica=id_analitica;
            IF not found
            THEN
                raise notice 'error analitica: % no existeix',id_analitica;
                return '1';
            ELSE
                sql1 := 'select * from analitiques where idanalitica=id_analitica';
            END IF;
        END IF;
    END IF;
    RETURN '0';
END;
$$
LANGUAGE 'plpgsql';
