--Diego Sanchez isx2031424
CREATE OR REPLACE FUNCTION informe_definitiu()
RETURNS TRIGGER AS
$$
DECLARE
    sql1 text := '';
    sql2 text := '';
    sql3 text := '';
    reg record;
    existeix int := 0;
    id_analitica int;
BEGIN
    -- en cas que l'operació sigui un delete anem a buscar el la idanalitica a la taula resultats
    IF (TG_OP = 'DELETE')
    THEN
        sql3 := 'SELECT * FROM resultats where idresultat=' || OLD.idresultat;
        FOR reg in EXECUTE(sql3)
        LOOP
            id_analitica := reg.idanalitica;
        END LOOP;
    ELSE
        id_analitica := NEW.idanalitica;
    END IF;

    --mirem si hi ha analitiques sense resultats encara
    sql1 := 'SELECT * FROM resultats 
    where idanalitica=' || id_analitica || 'and (resultats = '''' or resultats is NULL)';
    
    existeix := 0;
    FOR reg in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;

    IF existeix = 1
    THEN
        RETURN NEW;
    ELSE
        --mirem que no hi hagin resultats de l'analtica a resultats_patologic
        sql2 := 'SELECT * FROM resultats 
        JOIN resultats_patologics 
        on resultats.idresultat=resultat_patologics.idresultat 
        where idanalitica=' || id_analitica;
        existeix := 0;
        FOR reg in EXECUTE(sql2)
        LOOP
            existeix := 1;
        END LOOP;
        IF existeix = 1
        THEN
            RETURN NEW;
        ELSE
            -- si no hi ha resultats pendents per l'analitica la guardem a informes
            INSERT INTO informes SELECT id_analitica , NOW();
        END IF;
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER analitica_acabada
AFTER INSERT OR UPDATE ON resultats FOR EACH 
ROW EXECUTE PROCEDURE acabada();

CREATE TRIGGER analitica_acabada
AFTER DELETE ON resultat_patologics FOR EACH
ROW EXECUTE PROCEDURE acabada();

----------------------PROVES------------------------------

CREATE OR REPLACE FUNCTION informe_definitiu(id_analitica int)
RETURNS int AS
$$
DECLARE
    sql1 text := '';
    reg record;
    existeix int := 0;
BEGIN
    sql1 := 'SELECT * FROM resultats 
    where idanalitica=' || id_analitica || 'and (resultats = '''' or resultats is NULL)';
    FOR reg in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;

    return existeix;
END;
$$
LANGUAGE 'plpgsql';
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION informe_definitiu(id_analitica int)
RETURNS int AS
$$
DECLARE
    sql1 text := '';
    sql2 text := '';
    reg record;
    existeix int := 0;
BEGIN
    sql1 := 'SELECT * FROM resultats 
    where idanalitica=' || id_analitica || 'and (resultats = '''' or resultats is NULL)';
    FOR reg in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;

    IF existeix = 0
    THEN
        sql2 := 'SELECT * FROM resultats 
        JOIN resultats_patologics 
        on resultats.idresultat=resultats_patologics.idresultat 
        where idanalitica=' || id_analitica;
        FOR reg in EXECUTE(sql2)
        LOOP
            existeix := 1;
        END LOOP;
    END IF;
    return existeix;
END;
$$
LANGUAGE 'plpgsql';