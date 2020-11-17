--no existeix l'autor de l'obra introduida
INSERT INTO autors_obres
VALUES
(1,5)
;

--ERROR:  insert or update on table "autors_obres" violates foreign key constraint "autors_obres_id_autor_fkey"
--DETAIL:  Key (id_autor)=(5) is not present in table "autors".

--no existeix l'obra de l'autor introduit
INSERT INTO autors_obres
VALUES
(5,2)
;

--ERROR:  insert or update on table "autors_obres" violates foreign key constraint "autors_obres_id_obra_fkey"
--DETAIL:  Key (id_obra)=(5) is not present in table "obres".


--no existeix l'obra de la edicio introduida

INSERT INTO edicions
VALUES
(11,10,'1570-09-15','english','United Kingdom')
;

--ERROR:  insert or update on table "edicions" violates foreign key constraint "edicions_id_obra_fkey"
--DETAIL:  Key (id_obra)=(10) is not present in table "obres".

--no existeix l'edicio del volum introduit
INSERT INTO volums
VALUES
(8,1,11)
;

--ERROR:  insert or update on table "volums" violates foreign key constraint "volums_id_edicio_fkey"
--DETAIL:  Key (id_edicio)=(11) is not present in table "edicions".

--no existeix el volum dels exemplars
INSERT INTO exemplars
VALUES
(1011,0,8)
;

--ERROR:  insert or update on table "exemplars" violates foreign key constraint "exemplars_id_volum_fkey"
--DETAIL:  Key (id_volum)=(8) is not present in table "volums".

--no existeix el soci que ha demanat el prestec
INSERT INTO prestec
VALUES
(1010,20,'no','2020-11-01',NULL)
;

--ERROR:  insert or update on table "prestec" violates foreign key constraint "prestec_id_soci_fkey"
--DETAIL:  Key (id_soci)=(20) is not present in table "socis".

--no existeix el llibre que el soci ha demanat 
INSERT INTO prestec
VALUES
(2010,2,'no','2020-11-01',NULL)
;

--ERROR:  insert or update on table "prestec" violates foreign key constraint "prestec_num_referencia_fkey"
--DETAIL:  Key (num_referencia)=(2010) is not present in table "exemplars".

--no existeix ni tema ni subtema del llibre introduit
INSERT INTO obres_temas
VALUES
(4,10)
;

--ERROR:  insert or update on table "obres_temas" violates foreign key constraint "obres_temas_id_tema_fkey"
--DETAIL:  Key (id_tema)=(10) is not present in table "tema".

--no existeix el llibre del tema introduit
INSERT INTO obres_temas
VALUES
(20,5)
;

--ERROR:  insert or update on table "obres_temas" violates foreign key constraint "obres_temas_id_obra_fkey"
--DETAIL:  Key (id_obra)=(20) is not present in table "obres".