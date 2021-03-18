CREATE OR REPLACE FUNCTION evaluar()
RETURNS trigger AS
$$
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
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER in_evaluar 
BEFORE INSERT OR UPDATE ON resultats FOR EACH 
ROW EXECUTE PROCEDURE evaluar();