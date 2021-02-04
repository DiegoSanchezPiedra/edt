CREATE OR REPLACE FUNCTION updinsert()
RETURNS text AS
$$
DECLARE
 	result text := '';
 	searchsql text := '';
	count_existe text := '';
; 	res_select record;
BEGIN
 	searchsql := 'SELECT idpacient from pacients';
	FOR res_select IN EXECUTE(searchsql) LOOP
		count_existe := 'select count(*) from pacients where idpacient=(select idpacient from nous_pacients where idpacient=pacient);';
			for 
		IF count_existe != '1':
		 	insert into pacients values 
		ELSE
 			update
		END IF;
 	END LOOP;
 	IF result = '' THEN
 		result := 'Dades inexistents';
	END IF;

   	RETURN searchsql || ': ' || result;
EXCEPTION 
  	WHEN others THEN return '5';
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE;