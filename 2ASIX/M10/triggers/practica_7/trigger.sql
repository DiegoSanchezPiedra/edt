CREATE OR REPLACE FUNCTION insert_log()
RETURNS TRIGGER AS
$$
DECLARE
    id int;
BEGIN
    IF TG_OP = 'DELETE'
    THEN
        IF TG_TABLE_NAME = 'resultats'
        THEN
            id = OLD.idresultat;
        ELSE
            IF TG_TABLE_NAME = 'analitiques'
            THEN
                id = OLD.idanalitica;
            END IF;
        END IF;
    ELSE
        IF TG_TABLE_NAME = 'resultats'
        THEN
            id = NEW.idresultat;
        ELSE
            IF TG_TABLE_NAME = 'analitiques'
            THEN
                id = NEW.idanalitica;
            END IF;
        END IF;
    END IF; 
END;
$$
LANGUAGE 'plpgsql';

