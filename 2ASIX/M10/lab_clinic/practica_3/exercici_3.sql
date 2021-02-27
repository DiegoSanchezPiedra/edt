CREATE OR REPLACE FUNCTION resultats(idresultat int)
RETURNS text AS
$$
DECLARE
    sql1 text := '';
    reg_1 record;
    provatecnica text := '';
    pacient text := '';
    resultat text := '';
    res text := '';
BEGIN
    sql1 := 'SELECT * from resultats where idresultat=' || idresultat;
    FOR reg_1 in EXECUTE(sql1)
    LOOP
        provatecnica := reg_1.idprovatecnica;
        resultat := reg_1.resultats;
    END LOOP;

    sql1 := 'SELECT * from analitiques where idanalitica = (SELECT idanalitica from resultats where idresultat =' || idresultat || ')';
    FOR reg_1 in EXECUTE(sql1)
    LOOP
        pacient := reg_1.idpacient;
    END LOOP;

    --raise notice '% idprovatecnica',provatecnica;
    --raise notice '% pacient',pacient;
    --raise notice '% resultat',resultat;
    res := grau_perill(provatecnica::int,pacient::int,resultat);
    return res;
END;
$$
LANGUAGE 'plpgsql';