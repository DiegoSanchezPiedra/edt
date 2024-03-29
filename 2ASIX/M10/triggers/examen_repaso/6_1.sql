CREATE TABLE resultat_patologics(
    idresultat int NOT NULL,
    stamp timestamp NOT NULL,
    userid text NOT NULL
);
----------------------------------------------------
CREATE OR REPLACE FUNCTION in_res_patologic()
RETURNS TRIGGER AS
$$
DECLARE
    id_provatecnica int;
    id_pacient int;
    resultat text := '';
    grau text := '';
    sql1 text := '';
    registre record;
    existeix int := 0;
BEGIN
    --control d'errors
    --mirem si exsiteix el pacient donat
    sql1 := 'select * from pacients where idpacient=' || NEW.idpacient;
    FOR registre in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;
    IF existeix = 0
    THEN
        RETURN NULL;
    END IF;
    --mirem si exsiteix la provatecnica donada
    existeix := 0;
    sql1 := 'select * from provestecnica where idprovatecnica=' || NEW.idprovatecnica;
    FOR registre in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;
    IF existeix = 0
    THEN
        RETURN NULL;
    END IF;

    id_provatecnica := NEW.idprovatecnica;
    id_pacient := NEW.idpacient;
    resultat := NEW.resultat;
    --mirem que el resultat no sigui buit
    IF resultat = '' OR resultat IS NULL
    THEN
        raise EXCEPTION 'resultat no donat';
        RETURN NULL;
    END IF;

    grau := grau_perill(id_provatecnica,id_pacient,resultat);
    IF grau = '3' OR grau = '2'
    THEN
        INSERT INTO resultat_patologics (idresultat,stamp,userid) VALUES (NEW.idresultat,CURRENT_TIMESTAMP,user);
        RETURN NEW;
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
-----------------------------------------------------
CREATE TRIGGER id_res_patologic BEFORE INSERT OR UPDATE ON resultats FOR EACH ROW PROCEDURE in_res_patologic();