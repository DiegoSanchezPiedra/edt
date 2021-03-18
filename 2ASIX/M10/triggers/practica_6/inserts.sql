--Diego Sanchez
-- isx2031424

--per fer la prova de la practia 1 apartat 1 de triggers
CREATE TABLE resultats_patologics(
    idresultat int not null,
    stamp timestamp not null,
    userid text not null
);

insert into analitiques
values(DEFAULT,1,2,current_date);

insert into resultats 
values(DEFAULT,4,1,'160',current_date);

insert into analitiques
values(DEFAULT,1,2,current_date);

insert into resultats
values(DEFAULT,5,1,'100',current_date);


-- per fer la prova a la practica 1 apartat 2 de triggers
delete from resultats
where idresultat = 3;

delete from analitiques
where idanalitica = 5;


--3.
-- practia 1 apartat 3 triggers
CREATE TABLE informes(
    idanalitica bigint not null,
    stamp timestamp not null
);

insert into analitiques
values(DEFAULT,1,2,current_date);

insert into resultats 
VALUES(DEFAULT,6,1,'',current_date);