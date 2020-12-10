--error taula usuaris, nickname reptit
insert into usuaris
values
(5,'didi','0051613389364','diale@gmail.com','trujillo','312433','diego');

--------------------------------------------------------------

--ERROR:  duplicate key value violates unique constraint "usuaris_nickname_key"
--DETAIL:  Key (nickname)=(didi) already exists.

--------------------------------------------------------------

--error taula usuaris:
    --id_usuari no existeix
    insert into seguidors
    values
    (11,5,1);

    --ERROR:  insert or update on table "seguidors" violates foreign key constraint "seguidors_id_usuari_fkey"
    --DETAIL:  Key (id_usuari)=(5) is not present in table "usuaris".

    --id_seguidor no existeix
    insert into seguidors
    values
    (11,4,5);

    --ERROR:  insert or update on table "seguidors" violates foreign key constraint "seguidors_id_seguidor_fkey"
    --DETAIL:  Key (id_seguidor)=(5) is not present in table "usuaris".

--------------------------------------------------------------

--error taula publiacions, l'usuari no existeix
insert into publicacions
values
(5,5,'13:20:20','2019-02-20',true);

--ERROR:  insert or update on table "publicacions" violates foreign key constraint "publicacions_id_usuari_fkey"
--DETAIL:  Key (id_usuari)=(5) is not present in table "usuaris".

--------------------------------------------------------------

--error taula rating
    --l'usuari no existeix
    insert into rating
    values
    (12,4,5,true);
    
    --ERROR:  insert or update on table "rating" violates foreign key constraint "rating_id_usuari_fkey"
    --DETAIL:  Key (id_usuari)=(5) is not present in table "usuaris".

    --la publiacio no existeix
    insert into rating
    values
    (12,5,4,true);

    --ERROR:  insert or update on table "rating" violates foreign key constraint "rating_id_pub_fkey"
    --DETAIL:  Key (id_pub)=(5) is not present in table "publicacions".