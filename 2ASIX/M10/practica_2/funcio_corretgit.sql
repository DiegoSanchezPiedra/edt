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
            raise notice '% no existeix',res_sql1.idpacient;           
            
            sql3 := 'insert into pacients (idpacient,nom,cognoms,dni,data_naix,sexe,adreca,ciutat,c_postal,telefon,email,num_ss,nie,passaport) 
            values (' || res_sql1.idpacient || ',''' || res_sql1.nom || ''',''' || res_sql1.cognoms || ''',''' || res_sql1.data_naix || ''',''' || res_sql1.ciutat ||
             ''',''' || res_sql1.c_postal || ''',''' || res_sql1.telefon || ''',''' || res_sql1.email || ''',''' || res_sql1.nie ||''')';
        ELSE
            raise notice '% si existeix UPDATE' ,res_sql1.idpacient;
            
            sql3 := 'update pacients set
             nom=''' || res_sql1.nom || '''
            , cognoms=''' || res_sql1.cognoms || '''
            , data_naix=''' || res_sql1.data_naix || '''
            , sexe=''' || res_sql1.sexe || '''
            , adreca=''' || res_sql1.adreca || '''
            , ciutat=''' || res_sql1.ciutat || '''
            , c_postal=''' || res_sql1.c_postal || '''
            , telefon=''' || res_sql1.telefon || '''
            , email=''' || res_sql1.email || '''
            , nie=''' || res_sql1.nie || '''';   

        END IF;

        --EXECUTE (sql3);
         
        sql4 := 'DELETE FROM nous_pacients where idpacient=''' || res_sql1.idpacient || '''';

        --EXECUTE (sql4);
        raise notice 'sentencia: % ',sql3;
    END LOOP;
    RETURN 1;
END;
$$
LANGUAGE 'plpgsql' VOLATILE;


sql3 := 'insert into pacients (idpacient,nom,cognoms,dni,data_naix,sexe,adreca,ciutat,c_postal,telefon,email,num_ss,nie,passaport) 
            values (' || res_sql1.idpacient || ',' || quote_nullabe(res_sql1.nom) || ',' || quote_nullabe(res_sql1.cognoms) || ',' || quote_nullable(res_sql1.data_naix) || ',' || quote_nullable(res_sql1.ciutat) ||
             ',' || quote_nullabe(res_sql1.c_postal) || ',' || quote_nullable(res_sql1.telefon) || ',' || quote_nullable(res_sql1.email) || ',' || quote_nullable(res_sql1.num_ss) || ',' || quote_nullable(res_sql1.num_cat) ||
             ',' || quote_nullable(res_sql1.nie) || ',' || quote_nullable(res_sql1.passaport) || ')';

sql4 := 'update pacients set
            idpacient=' || res_sql1.idpacient || '
            , nom=' || quote_nullable(res_sql1.nom) || '
            , cognoms=' || quote_nullable(res_sql1.cognoms) || '
            , dni=' '' || quote_nullable(res_sql1.dni) || '' '
            , data_naix=' || quote_nullable(res_sql1.data_naix) || '
            , sexe=' || quote_nullable(res_sql1.sexe) || '
            , adreca=' || quote_nullable(res_sql1.adreca) || '
            , ciutat=' || quote_nullable(res_sql1.ciutat) || '
            , c_postal=' || quote_nullable(res_sql1.c_postal) || '
            , telefon=' || quote_nullable(res_sql1.telefon) || '
            , email=' || quote_nullable(res_sql1.email) || '
            , num_ss=' || quote_nullable(res_sql1.num_ss) || '
            , num_cat=' || quote_nullable(res_sql1.num_cat) || '
            , nie=' || quote_nullable(res_sql1.nie) || '
            , passaport=' || quote_nullable(res_sql1.passaport) || ;


-----------------------------------------------EXEMPLE AMB QUOTE_NULLABLE()-------------------------------------------------

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
            --raise notice '% no existeix',res_sql1.idpacient;           
            
            sql3 := 'insert into pacients (idpacient,nom,cognoms,dni,data_naix,sexe,adreca,ciutat,c_postal,telefon,email,num_ss,num_cat,nie,passaport) 
            values (' || res_sql1.idpacient || ',' || quote_nullable(res_sql1.nom) || ',' || quote_nullable(res_sql1.cognoms) || ',' || quote_nullable(res_sql1.dni) || ',' || quote_nullable(res_sql1.data_naix) || ',' || quote_nullable(res_sql1.sexe) || ',' || quote_nullable(res_sql1.adreca) || ',' || quote_nullable(res_sql1.ciutat) ||
            ',' || quote_nullable(res_sql1.c_postal) || ',' || quote_nullable(res_sql1.telefon) || ',' || quote_nullable(res_sql1.email) || ',' || quote_nullable(res_sql1.num_ss) || ',' || quote_nullable(res_sql1.num_cat) ||
            ',' || quote_nullable(res_sql1.nie) || ',' || quote_nullable(res_sql1.passaport) || ')';
        ELSE
            --raise notice '% si existeix UPDATE' ,res_sql1.idpacient;
            
            sql3 := 'update pacients set
            nom=' || quote_nullable(res_sql1.nom) || '
            , cognoms=' || quote_nullable(res_sql1.cognoms) || '
            , dni=' || quote_nullable(res_sql1.dni) || '
            , data_naix=' || quote_nullable(res_sql1.data_naix) || '
            , sexe=' || quote_nullable(res_sql1.sexe) || '
            , adreca=' || quote_nullable(res_sql1.adreca) || '
            , ciutat=' || quote_nullable(res_sql1.ciutat) || '
            , c_postal=' || quote_nullable(res_sql1.c_postal) || '
            , telefon=' || quote_nullable(res_sql1.telefon) || '
            , email=' || quote_nullable(res_sql1.email) || '
            , num_ss=' || quote_nullable(res_sql1.num_ss) || '
            , num_cat=' || quote_nullable(res_sql1.num_cat) || '
            , nie=' || quote_nullable(res_sql1.nie) || '
            , passaport=' || quote_nullable(res_sql1.passaport);  

        END IF;

        --raise notice 'setencia: % ',sql3;
        EXECUTE (sql3);
         
        sql4 := 'DELETE FROM nous_pacients where idpacient=' || res_sql1.idpacient;

        --raise notice 'sentencia delete: % ',sql4;

        EXECUTE (sql4);
    
    END LOOP;
    RETURN 1;
    
    EXCEPTION
        WHEN others THEN return '0';
END;
$$
LANGUAGE 'plpgsql' VOLATILE;

-----------------------------------------------------------------------------------------------------------------------------------------------