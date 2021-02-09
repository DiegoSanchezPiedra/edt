CREATE OR REPLACE FUNCTION prova()
RETURNS text AS
$$
declare 
    sql1 text:='';
    sql2 text:='';
    sql3 text:='';
    sql4 text:='';
    res_sql1 record;
    res_sql2 record;
    existeix int:= 0;
BEGIN
    sql1 := 'select * from nous_pacients';
    for res_sql1 in EXECUTE(sql1)
    LOOP
        sql2 := 'select * from pacients where idpacient=''' || res_sql1.idpacient || ' '' ';
            raise notice 'sentencia: %', sql2;
        existeix := 0;
        FOR res_sql2 in EXECUTE(sql2) 
        LOOP
            existeix := 1;
        END LOOP;
        
        IF existeix = 0
        THEN
            sql3 := 'insert into pacients (idpacient,nom,cognom,dni,data_naix,sexe,adreca,ciutat,c_postal,telefon,email,num_ss,nie,passaport) 
            values (' || res_sql1.idpacient || ',''' || res_sql1.nom || ''',''' || res_sql1.cognoms || ''',''' || res_sql1.data_naix || ''',''' || res_sql1.ciutat ||
             ''',''' || res_sql1.c_postal || ''',''' || res_sql1.telefon || ''',''' || res_sql1.email || ''',''' || res_sql1.nie ||''')';

            raise notice '% no existeix',res_sql1.idpacient;
        --ELSE

        END IF;
        raise notice  'sentencia: %',sql3;
    
    END LOOP;
    RETURN 1;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;


sql3 := 'insert into pacients (idpacient,nom,cognom,dni,data_naix,sexe,adreca,ciutat,c_postal,telefon,email,num_ss,nie,passaport) 
            values (' || res_sql1.idpacient || ',''' || res_sql1.nom || ''',''' || res_sql1.cognoms || ''',''' || res_sql1.data_naix || ''',''' || res_sql1.ciutat ||
             ''',''' || res_sql1.c_postal || ''',''' || res_sql1.telefon || ''',''' || res_sql1.email || ''',''' || res_sql1.num_ss || ''',''' || res_sql1.num_cat ||
             ''',''' || res_sql1.nie || ''',''' || res_sql1.passaport || ''')';