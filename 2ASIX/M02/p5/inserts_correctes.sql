INSERT INTO autors
VALUES
(1,'Miguel de Cervantes','1547-09-29','Spain',NULL),
(2,'Antonio Machado','1875-07-26','Spain',NULL),
(3,'William Shakespeare','1564-04-23','United Kingdom',NULL),
(4,'Juan Villoro','1956-09-24','Mexico','Mexico')
;

INSERT INTO obres
VALUES 
(1,'Don Quijote de la Mancha','spanish',1605,1605),
(2,'El disparo de argon','spanish',1991,2005),
(3,'Campos de Castilla','spanish',1912,1912),
(4,'Romeo y Julieta','english',1597,1597)
;

INSERT INTO autors_obres
VALUES
(1,1),
(2,4),
(3,2),
(4,3)
;

INSERT INTO edicions
VALUES
(1,1,'2000-01-01','spanish','Peru'),
(2,1,'2001-02-02','spanish','Argentina'),
(3,1,'2001-03-21','english','United Estates'),
(4,2,'2005-02-01','spanish','Venezuela'),
(5,2,'2006-03-01','italian','Italy'),
(6,2,'2010-10-01','german','Germany'),
(7,3,'2005-11-20','spanish','Paraguay'),
(8,3,'2001-11-20','spanish','Spain'),
(9,4,'1999-12-01','spanish','Spain'),
(10,4,'1570-09-15','english','United Kingdom')
;

INSERT INTO volums
VALUES
(1,1,1),
(2,3,2),
(3,1,6),
(4,2,4),
(5,2,8),
(6,1,10),
(7,3,5)
;

INSERT INTO exemplars
VALUES
(1004,5,1),
(1005,2,2),
(1006,0,3),
(1007,10,4),
(1008,3,5),
(1009,4,6),
(1010,0,7)
;

INSERT INTO socis
VALUES
(1,'diego','sanchez','evarist arnus 45','Barcelona','12345678D','2000-03-17','man'),
(2,'gabriel','figueira','muntaner 30','Barcelona','87654321G','1999-08-25','man'),
(3,'joaquin','figueira','muntaner 30','Barcelona','21324354J','1999-08-25','man'),
(4,'Evelyn','Escobar','victoria 12','Barbera del valles','12345678E','2002-12-10','woman'),
(5,'Valeria','Cuba','la perla 13','Castelldefels','12345678V','2004-05-15','woman'),
(6,'Jeampier','cuba','la perla 13','Castelldefels','12345678J','2001-10-15','man'),
(7,'Alessandra','Romero','Miguel Grau 50','Sant vicente','12345678A','2000-10-10','woman'),
(8,'Santino','rial','brafim 134','Barcelona','12345678S','2000-01-01','man'),
(9,'Lucas','Zendrera','diagonal 404','Barcelona','12345678L','2000-12-12','man'),
(10,'Amanda','Sanchez','evarist arnus 45','Barcelona','12345678Z','1998-03-06','woman')
;

INSERT INTO prestec
VALUES
(1010,2,'no','2020-11-01',NULL),
(1005,1,'si','2020-11-02','2020-11-17')
;

INSERT INTO tema
VALUES
(1,'drama','tema drama'),
(2,'terror','tema terror'),
(3,'terror-psicologico','subtema de terror'),
(4,'gore','subtema de terror'),
(5,'thriller','subtema de terror'),
(6,'tragedia','subtema de drama'),
(7,'historico','subtema de drama')
;

INSERT INTO subtema
VALUES
(5,1),
(6,1),
(3,2),
(4,2),
(5,2)
;

INSERT INTO obres_temas
VALUES
(1,2),
(1,4),
(2,1),
(3,1),
(3,6),
(3,2),
(4,3)
;