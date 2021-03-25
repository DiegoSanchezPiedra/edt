--Diego Sanchez Piedra
--isx2031424
lab_clinic_1=# update resultats set resultats = '150' where idresultat=1;
UPDATE 1
lab_clinic_1=# select * from resultats_repetits ;
 idresultat | repeticio | idanalitica | idprovatecnica | resultat |        dataresultat        
------------+-----------+-------------+----------------+----------+----------------------------
          1 |         1 |           1 |              1 | 160      | 2021-03-25 09:10:26.166503
(1 row)


--------------------------------------------------------------------------------------------------------------

lab_clinic_1=# update resultats set resultats = '140' where idresultat=1;
UPDATE 1
lab_clinic_1=# select * from resultats_repetits ;
 idresultat | repeticio | idanalitica | idprovatecnica | resultat |        dataresultat        
------------+-----------+-------------+----------------+----------+----------------------------
          1 |         1 |           1 |              1 | 160      | 2021-03-25 09:10:26.166503
          1 |         2 |           1 |              1 | 150      | 2021-03-25 09:10:26.166503
(2 rows)

--------------------------------------------------------------------------------------------------------------

lab_clinic_1=# update resultats set resultats = '130' where idresultat=1;
UPDATE 1
lab_clinic_1=# select * from resultats_repetits ;
 idresultat | repeticio | idanalitica | idprovatecnica | resultat |        dataresultat        
------------+-----------+-------------+----------------+----------+----------------------------
          1 |         1 |           1 |              1 | 160      | 2021-03-25 09:10:26.166503
          1 |         2 |           1 |              1 | 150      | 2021-03-25 09:10:26.166503
          1 |         3 |           1 |              1 | 140      | 2021-03-25 09:10:26.166503
(3 rows)

--------------------------------------------------------------------------------------------------------------

lab_clinic_1=# INSERT INTO resultats (idresultat,idanalitica,idprovatecnica,resultats,dataresultat) VALUES (7,10,1,'',CURRENT_TIMESTAMP);
INSERT 0 1

lab_clinic_1=# update resultats set resultats = '130' where idresultat=7;
UPDATE 1
lab_clinic_1=# select * from resultats_repetits ;
 idresultat | repeticio | idanalitica | idprovatecnica | resultat |        dataresultat        
------------+-----------+-------------+----------------+----------+----------------------------
          1 |         1 |           1 |              1 | 160      | 2021-03-25 09:10:26.166503
          1 |         2 |           1 |              1 | 150      | 2021-03-25 09:10:26.166503
          1 |         3 |           1 |              1 | 140      | 2021-03-25 09:10:26.166503
(3 rows)