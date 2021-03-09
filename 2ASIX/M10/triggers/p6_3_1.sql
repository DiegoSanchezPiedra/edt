--Diego Sanchez isx2031424
CREATE OR REPLACE FUNCTION informe_definitiu()
RETURNS TRIGGER AS
$$
DECLARE
    sql1 text := '';
    sql2 text := '';
    reg record;
    existeix int := 0;
    existeix_analitica int := 0;
BEGIN
    IF NOT NEW.idanalitica
    THEN
        sql3 := 'SELECT * FROM resultats where idresultat=' || OLD.idresultat;
        FOR reg in EXECUTE(sql3)
        LOOP
            id_analitica := reg.idanalitica;
        END LOOP;
    ELSE
        id_analitica := NEW.idanalitica;
    END IF;

    sql1 := 'SELECT * FROM resultats 
    where idanalitica=' || id_analitica || 'and (resultats = '''' or resultats is NULL)';
    
    FOR reg in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;

    IF existeix = 1
    
    THEN
        RETURN NEW;
    ELSE
        sql2 := 'SELECT * FROM resultats 
        JOIN resultats_patologics 
        on resultats.idresultat=resultat_patologics.idresultat 
        where idanalitica=' || id_analitica;
        FOR reg in EXECUTE(sql2)
        LOOP
            existeix := 1;
        END LOOP;
        IF existeix = 1
        THEN
            RETURN NEW;
        ELSE
            INSERT INTO informes SELECT id_analitica , NOW()
        END IF;
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER analitica_acabada
AFTER INSERT ON informes FOR EACH 
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