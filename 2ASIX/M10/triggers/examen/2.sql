--Diego Sanchez Piedra
--isx2031424
CREATE OR REPLACE FUNCTION in_resultats_repetits()
RETURNS TRIGGER AS
$$
DECLARE
    repeticio int;
    sql1 text := '';
    registre record;
BEGIN
    --mirem si ja hi ha algun registre del resultat que s'ha fet abans i el sumen 1 (el seguent registre)
    sql1 := 'SELECT count(*) FROM resultats_repetits WHERE idresultat =' || OLD.idresultat;
    FOR registre in EXECUTE(sql1)
    LOOP
        repeticio := registre.count + 1;
    END LOOP;
    --repeticio := repeticio::int + 1;
    --mirem que tingui un resultat 
    IF OLD.resultats = '' OR OLD.resultats IS NULL
    THEN
        RETURN NEW;
    ELSE
        --inserim a la taula resultats_repetits
        INSERT INTO resultats_repetits (idresultat,repeticio,idanalitica,idprovatecnica,resultat,dataresultat)
        VALUES (OLD.idresultat,repeticio,OLD.idanalitica,OLD.idprovatecnica,OLD.resultats,OLD.dataresultat);

        RETURN NEW;
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

--------------------------------------------------------------------------------------
CREATE TRIGGER in_resultats_repetits 
AFTER UPDATE ON resultats FOR EACH 
ROW EXECUTE PROCEDUREin_resultats_repetits();
