--Diego Sanchez
--isx2031424
CREATE TABLE logs(
    nom_usuari varchar(255) NOT NULL,
    stamp timestamp NOT NULL,
    nom_taula varchar(255) NOT NULL,
    clau_primaria int NOT NULL,
    sentencia text
);
--------------------------------------------
CREATE OR REPLACE FUNCTION in_logs()
RETURNS TRIGGER AS
$$
DECLARE
    id int;
    sentencia text;
BEGIN
    --1)miramos si la operacion hecha es DELETE o (INSERT o UPDATE)
    IF TG_OP = 'DELETE'
    THEN
        --2)miramos si la tabla alterada es resultats o analitiques
        IF TG_TABLE_NAME = 'resultats'
        THEN
            id := OLD.idresultat;
        ELSE
            IF TG_TABLE_NAME = 'analitiques'
            THEN
                id := OLD.idanalitica;
            END IF;
        END IF;
        sentencia := TG_OP || OLD.*;
    --1)
    ELSE
        --2)
        IF TG_TABLE_NAME = 'resultats'
        THEN
            id := NEW.idresultat;
        ELSE
            IF TG_TABLE_NAME = 'analitiques'
            THEN
                id := NEW.idanalitica;
            END IF;
        END IF;
        sentencia := TG_OP || NEW.*;
    END IF;
    --hacemos el insert en la tabla de logs
    INSERT INTO logs (nom_usuari,stamp,nom_taula,clau_primaria,sentencia) VALUES (user,CURRENT_TIMESTAMP,TG_TABLE_NAME,id,sentencia);
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
----------------------------------------------------
CREATE TRIGGER del_log AFTER DELETE on resultats FOR EACH ROW EXECUTE PROCEDURE in_logs();
CREATE TRIGGER del_log AFTER DELETE on analitiques FOR EACH ROW EXECUTE PROCEDURE in_logs();

CREATE TRIGGER in_up_log AFTER INSERT OR UPDATE ON resultats FOR EACH ROW EXECUTE PROCEDURE in_logs();
CREATE TRIGGER in_up_log AFTER INSERT OR UPDATE ON analitiques FOR EACH ROW EXECUTE PROCEDURE in_logs();