CREATE OR REPLACE FUNCTION no_del()
RETURNS TRIGGER AS
$$
BEGIN
    RETURN NULL;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER no_del
BEFORE DELETE ON resultats FOR EACH ROW 
EXECUTE PROCEDURE no_del();

CREATE TRIGGER no_del
BEFORE DELETE ON analitiques FOR EACH ROW
EXECUTE PROCEDURE no_del();


--manera rapida d'afegir el MATEIX trigger amb la MATEIXA funcio per multiples taules
SELECT p.tablename
FROM pg_tables p
WHERE p.schemaname = 'public'
AND tablename = 'analitiques'
OR tablename = 'resultats'
;

'CREATE TRIGGER no_del 
BEFORE DELETE ON ' || p.tablename || '
FOR EACH ROW EXECUTE PROCEDURE no_del();
'