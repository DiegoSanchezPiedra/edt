CREATE OR REPLACE FUNCTION resultats_analitica(id_pacient INT,id_analitica INT DEFAULT NULL)
RETURNS text AS
$$
DECLARE
    selected_row record;
    sql1 text := '';
    registres_1 record;
    sql2 text := '';
    registres record;
    sql3 text := '';
    registres_2 record;
    res text := '';
    registre_trobat int := 0;
BEGIN
    --mirem si el pacient donat existeix
    sql1 := 'select * from pacients where idpacient=' || id_pacient;
    registre_trobat := 0;
    FOR selected_row in EXECUTE(sql1)
    LOOP
        registre_trobat := 1;
    END LOOP;

    IF registre_trobat = 0
    --si no existeix
    THEN
        raise notice 'error pacient: % no existeix',id_pacient;
        return '1';
    ELSE
        --si SI existeix
        IF id_analitica IS NULL
        THEN
            sql1 := 'select * from analitiques where idpacient=' || id_pacient || 'order by dataanalitica desc limit 1';   
        ELSE
            sql1 := 'select * from analitiques where idanalitica=' || id_analitica;
        END IF;
    END IF;
    
    registre_trobat := 0;
    FOR registres in EXECUTE(sql1)
    LOOP
        registre_trobat := 1;       
        sql2 := 'select * from resultats 
                JOIN provestecnica on resultats.idprovatecnica = provestecnica.idprovatecnica
                JOIN catalegproves on provestecnica.idprova = catalegproves.idprova
                WHERE resultats.idanalitica = ' || registres.idanalitica;
        
        FOR registres_1 in EXECUTE(sql2)
        LOOP
            res := res || 'Pacient:' || registres.idpacient || E'\t' || 'Data:' || registres.dataanalitica || E'\t' 
            || 'Prova:' || registres_1.idprova || E'\t' || 'Noma Prova:' || registres_1.nom_prova 
            || E'\t' || 'Resultats:' || registres_1.resultats || E'\t' || 'Valoracio:' || resultats(registres_1.idresultat::int) || E'\n';

            sql3 := 'select * from analitiques
                JOIN resultats on analitiques.idanalitica = resultats.idanalitica
                JOIN provestecnica on resultats.idprovatecnica = provestecnica.idprovatecnica
                JOIN catalegproves on provestecnica.idprova = catalegproves.idprova
                WHERE analitiques.idpacient = ' || registres.idpacient ||
                'AND catalegproves.idprova =' || registres_1.idprova ||
                'AND analitiques.idanalitica !=' || registres_1.idanalitica;

            FOR registres_2 in EXECUTE(sql3)
            LOOP
                res := res || '---------' || E'\t' || 'Data:' || registres.dataanalitica || E'\t' 
            || 'Prova:' || registres_2.idprova || E'\t' || 'Noma Prova:' || registres_2.nom_prova 
            || E'\t' || 'Resultats:' || registres_2.resultats || E'\t' || 'Valoracio:' || resultats(registres_2.idresultat::int) || E'\n';
            END LOOP;
        END LOOP;
    END LOOP; 
    RETURN res;
END;
$$
LANGUAGE 'plpgsql';