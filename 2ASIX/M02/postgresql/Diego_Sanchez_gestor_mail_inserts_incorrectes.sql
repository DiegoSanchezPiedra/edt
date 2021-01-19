---el grup no existeix
insert into adreçes_grups
values
(4,10,1);

--ERROR:  insert or update on table "adreçes_grups" violates foreign key constraint "adreçes_grups_id_adreça_grup_fkey"
--DETAIL:  Key (id_adreça_grup)=(10) is not present in table "adreçes".

-- l'usuari no existeix
insert into adreçes_grups
values
(4,5,10);

--ERROR:  insert or update on table "adreçes_grups" violates foreign key constraint "adreçes_grups_id_adreça_usuari_fkey"
--DETAIL:  Key (id_adreça_usuari)=(10) is not present in table "adreçes".

--l'emissor del missatge no existeix
insert into missatges
values
(5,10,'bon mati');

--ERROR:  insert or update on table "missatges" violates foreign key constraint "missatges_emissor_fkey"
--DETAIL:  Key (emissor)=(10) is not present in table "adreçes".

-- el recepto del missatge no existeix
insert into missatges_adreçes
values
(6,2,10,'to');

--ERROR:  insert or update on table "missatges_adreçes" violates foreign key constraint "missatges_adreçes_receptor_fkey"
--DETAIL:  Key (receptor)=(10) is not present in table "adreçes".

-- el missatge no existeix
insert into missatges_adreçes
values
(6,5,4,'to');

--ERROR:  insert or update on table "missatges_adreçes" violates foreign key constraint "missatges_adreçes_id_missatge_fkey"
--DETAIL:  Key (id_missatge)=(5) is not present in table "missatges".
