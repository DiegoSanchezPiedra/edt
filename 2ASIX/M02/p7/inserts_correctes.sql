--taula provincies
insert into provincies
values
(1,'Barcelona'),
(2,'Lleida'),
(3,'Girona');

--taula ciutats
insert into ciutats
values
(1,2,'Lleida'),
(2,2,'Alcarras'),
(3,2,'Alguaire'),
(4,1,'Tarrassa'),
(5,1,'Barcelona'),
(6,1,'Castelldefels'),
(7,3,'Figueres'),
(8,3,'Olot');

--taula magatzems
insert into magatzems
values
(1,1,2),
(2,1,2),
(3,2,2),
(4,3,2),
(5,3,2),
(6,4,1),
(7,5,1),
(8,5,1),
(9,5,1),
(10,5,1),
(11,6,1),
(12,7,3),
(13,8,3);

--taula productes i poductes mare
insert into productes
values
(1,'NEWSKILL-cadira','cadira oficina',20),
(2,'IKEA-taula','taula oficina',50),
(3,'IKEA-reposapeus','reposapeus oficina',10),
(4,'LG-monitor','monitor per a pc full HD 1920x1080',150),
(5,'logitech-teclat','telcat de membrana per a pc',20),
(6,'logitech-ratoli','ratoli amb cable ergonomic per a pc',20),
(7,'intel-i7-10600K','processador intel per a una torre',500),
(8,'AMD-RX-6800XT','tarjeta grafica AMD per a una torre',599),
(9,'G-SKILL-32GB-4000MHz','memoria ram per una torre',200),
(10,'Samsung-SSD-M2-500GB','unitat emmagatzematge estat solid 500GB',120),
(11,'torre-pc','torre pc per a treballar',2000),
(12,'set-up-sencer','set up de pc monitor ratoli teclat i torre',3000);

insert into productes_mare
values
(4,12),
(5,12),
(6,12),
(7,11),
(7,12),
(8,11),
(8,12),
(9,11),
(9,12),
(10,11),
(10,12);

--taula productes_magatzems
insert into productes_magatzems
values
(1,1),
(1,2),
(2,1);

--taula venedors i supervisors
insert into venedors
values
(1,'Gabriel','Figueira','2019-03-17',1500,10,5,1),
(2,'Joaquin','Figueira','2019-03-17',1500,10,7,3),
(3,'Santino','Rial','2020-01-15',1500,10,1,2),
(4,'Bruno','Varela','2020-01-10',1500,10,6,1),
(5,'Robert','Valerio','2019-05-05',2000,40,3,2),
(6,'Pablo','Oyaneder','2019-12-29',2000,50,4,1);

insert into supervisors
values
(1,6),
(2,5),
(3,5),
(4,6),
(5,5),
(6,6);

--taula clients
insert into clients
values
(1,'evarist-arnus 45','evarist-arnus 45','Diego','Sanchez','08014',5,1),
(2,'diagonal 404','muntaner 500','Lucas','Zendrera','08020',7,3),
(3,'diputacio 20','diputacio 20','Jordi','Vilaro','08050',3,2),
(4,'gracia 50','via augusta 10','Samantha','Sancho','08090',4,1);

--taula comandes i linia_comanda
insert into comandes
values
(1,2,'2020-06-20',true),
(2,1,'2020-01-20',true),
(3,4,'2020-10-20',false);

insert into linia_comanda
values
(1,1,11,10),
(1,1,1,10),
(2,3,5,30),
(2,3,6,30),
(3,4,7,40),
(3,4,8,40),
(3,4,9,40);