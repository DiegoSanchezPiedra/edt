--taula usuaris
insert into usuaris
values
(1,'chriswar','003466655543','chris200@gmail.com','barcelona','123456','christian'),
(2,'mark','003455566643','mark@gmail.com','madrid','654321','mark_santiago'),
(3,'javi','0034777666555','jmoyano@gmail.com','lima','321435','javier_moyano'),
(4,'didi','0051603389364','dialesanchez@gmail.com','chimbote','312432','diego_sanchez');

--------------------------------------------------------------

--taula seguidors
insert into seguidors
values
(1,1,2),
(2,3,2),
(3,4,2),
(4,2,1),
(5,2,3),
(6,2,4),
(7,3,1),
(8,3,4),
(9,4,1),
(10,4,3);

--------------------------------------------------------------

--taula publicacions
insert into publicacions
values
(1,4,'12:04:60','2020-12-01',true),
(2,4,'05:00:00','2020-06-15',true),
(3,1,'00:30:00','2019-03-20',true),
(4,2,'13:20:20','2019-02-20',true);

--------------------------------------------------------------

--taula rating
insert into rating
values
(1,1,2,true),
(2,1,3,false),
(3,1,1,true),
(4,2,2,true),
(5,2,4,true),
(6,3,2,false),
(7,3,3,true),
(8,3,4,true),
(9,4,1,false),
(10,4,3,true),
(11,4,4,true);
