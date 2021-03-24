CREATE TABLE informes(
    idanalitica bigint NOT NULL,
    stamp timestamp NOT NULL
);
---------------------------------------------
CREATE OR REPLACE FUNCTION in_informes()
RETURNS TRIGGER AS
$$
DECLARE
    id_analitica int;
    existeix int := 0;
    registre record;
BEGIN
    --mirem si s'esborra a resultats_patologics o s'inserta a resultat
    IF TG_OP = 'DELETE'
    THEN
        id_analitica := OLD.idanalitica;
    ELSE
        id_analitica := NEW.idanalitica;
    END IF;

    --miramos si el resultado de la analitica está en resultats_patologics
    sql1 := 'SELECT * FROM resultas_patologics where idresultat = (SELECT idresultat FROM resultats WHERE idanalitica=' || id_analitica || ')';
    existeix := 0;
    FOR registre IN EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;
    IF existeix = 0
    THEN
        RETURN NULL;
    END IF;

    --miramos si el resultado de la tabla resultados tiene o no un resultado
    sql1 := 'SELECT * FROM resultats where idanalitica=' || id_analitica;
    existeix := 0;
    FOR registre in EXECUTE(sql1)
    LOOP
        existeix := 1;
    END LOOP;
    IF existeix = 0;
        RETURN NULL;
    END IF;

    INSERT INTO informes (idanalitica,stamp) VALUES (id_analitica,CURRENT_TIMESTAMP);
END;
$$
LANGUAGE 'plpgsql'