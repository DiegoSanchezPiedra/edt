--la provincia posada a la taula ciutats no es troba a la taula provincies
insert into ciutats
values
(9,4,'Tarragona');
--ERROR:  insert or update on table "ciutats" violates foreign key constraint "ciutats_id_provincia_fkey"
--DETAIL:  Key (id_provincia)=(4) is not present in table "provincies".


--la ciuta posada a la taula magatzems no es troba a la taula ciutats
insert into magatzems
values
(14,9,3);
--ERROR:  insert or update on table "magatzems" violates foreign key constraint "magatzems_id_ciutat_id_provincia_fkey"
--DETAIL:  Key (id_ciutat, id_provincia)=(9, 3) is not present in table "ciutats".


--la provincia posada a la taula magatzems no es troba a la taula ciutats per tant
--tampoc a la taula provincies
insert into magatzems
values
(14,7,4);
--ERROR:  insert or update on table "magatzems" violates foreign key constraint "magatzems_id_ciutat_id_provincia_fkey"
--DETAIL:  Key (id_ciutat, id_provincia)=(7, 4) is not present in table "ciutats".


--el producte posat a la taula productes mare no es troba a la taula productes
insert into productes_mare
values
(13,11);
--ERROR:  insert or update on table "productes_mare" violates foreign key constraint "productes_mare_id_producte_fkey"
--DETAIL:  Key (id_producte)=(13) is not present in table "productes".


--el producte mare posat a la taula productes_mare no es troba a la taula productes
insert into productes_mare
values
(6,13);
--ERROR:  insert or update on table "productes_mare" violates foreign key constraint "productes_mare_id_produte_mare_fkey"
--DETAIL:  Key (id_produte_mare)=(13) is not present in table "productes".


--la ciutat introduida a la taula venedors no es troba a la taula ciutats
insert into venedors
values
(7,'Michael','Ayala','2019-12-30',1500,10,3);
--ERROR:  insert or update on table "venedors" violates foreign key constraint "venedors_id_ciutat_id_provincia_fkey"
--DETAIL:  Key (id_ciutat, id_provincia)=(3, 1) is not present in table "ciutats".


--la provincia introduida a la taula venedors no es troba a la taula ciutats per tant tamapoc a la taula provincies
insert into venedors
values
(7,'Michael','Ayala','2019-12-30',1500,5,4);
--ERROR:  insert or update on table "venedors" violates foreign key constraint "venedors_id_ciutat_id_provincia_fkey"
--DETAIL:  Key (id_ciutat, id_provincia)=(4, 2) is not present in table "ciutats".


--el venedor introduit a la taula supervisors no es troba a la taula venedors
insert into supervisors
values
(7,5);
--ERROR:  insert or update on table "supervisors" violates foreign key constraint "supervisors_id_venedor_fkey"
--DETAIL:  Key (id_venedor)=(7) is not present in table "venedors".


--el supervisor introduit a la taula supervisors no es troba a la taula venedors
insert into supervisors
values
(6,7);
--ERROR:  insert or update on table "supervisors" violates foreign key constraint "supervisors_id_supervisor_fkey"
--DETAIL:  Key (id_supervisor)=(7) is not present in table "venedors".


--la ciutat introduida a la taula clients no es troba a la taula ciutats
insert into clients
values
(5,'vallcarca 101','vallcarca 101','Joel','Vale','08010',9,3);
--ERROR:  insert or update on table "clients" violates foreign key constraint "clients_id_ciutat_id_provincia_fkey"
--DETAIL:  Key (id_ciutat, id_provincia)=(9, 3) is not present in table "ciutats".


--la provincia introduida a la taula clients no es troba a la taula ciutats per tant tamapoc a la taula provincies
insert into clients
values
(5,'vallcarca 101','vallcarca 101','Joel','Vale','08010',5,4);
--ERROR:  insert or update on table "clients" violates foreign key constraint "clients_id_ciutat_id_provincia_fkey"
--DETAIL:  Key (id_ciutat, id_provincia)=(5, 4) is not present in table "ciutats".


--el client introduit a la taula comandes no es troba la taula clients
insert into comandes
values
(4,5,'2020-07-20',true);
--ERROR:  insert or update on table "comandes" violates foreign key constraint "comandes_id_client_fkey"
--DETAIL:  Key (id_client)=(5) is not present in table "clients".


--linia_comanda
--la comanda no es troba a taula comandes
insert into linia_comanda
values
(4,4,4,'2020-10-20',8,40,'2020-11-01');
--ERROR:  insert or update on table "linia_comanda" violates foreign key constraint "linia_comanda_id_comanda_id_client_data_comanda_fkey"
--DETAIL:  Key (id_comanda, id_client, data_comanda)=(4, 4, 2020-10-20) is not present in table "comandes".


--el venedor introuit no es troba a la taula venedors
insert into linia_comanda
values
(3,10,4,'2020-10-20',7,40,'2020-10-20');
--ERROR:  insert or update on table "linia_comanda" violates foreign key constraint "linia_comanda_id_venedor_fkey"
--DETAIL:  Key (id_venedor)=(10) is not present in table "venedors".


--el client introduit no es troba a la taula clients
insert into linia_comanda
values
(3,4,10,'2020-10-20',7,40,'2020-09-20');
--ERROR:  insert or update on table "linia_comanda" violates foreign key constraint "linia_comanda_id_comanda_id_client_data_comanda_fkey"
--DETAIL:  Key (id_comanda, id_client, data_comanda)=(3, 10, 2020-10-20) is not present in table "comandes".


--el producte no es troba a la taula productes
insert into linia_comanda
values
(3,4,4,'2020-10-20',30,40,'2020-09-20');
--ERROR:  insert or update on table "linia_comanda" violates foreign key constraint "linia_comanda_id_producte_fkey"
--DETAIL:  Key (id_producte)=(30) is not present in table "productes".


--el client intenta demanar una quantitat diferent del mateix producte
insert into linia_comanda
values
(3,4,4,'2020-10-20',9,10,'2020-09-22');

--ERROR:  duplicate key value violates unique constraint "linia_comanda_id_comanda_id_client_id_producte_key"
--DETAIL:  Key (id_comanda, id_client, id_producte)=(3, 4, 9) already exists.
