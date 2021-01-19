insert into adreçes
values
(1,'Mark@edt.org','Mark Santiago'),
(2,'Chris@edt.org','Christian Manalo'),
(3,'Javi@edt.org','Javier Moyano'),
(4,'Diego@edt.org','Diego Sanchez'),
(5,'escola@edt.org','grup escola');

insert into adreçes_grups
values
(1,5,1),
(2,5,2),
(3,5,3);

insert into missatges
values
(1,4,'hola que tal','false'),
(2,1,'deberes sistemas','true'),
(3,3,'soluciones practica m04','false'),
(4,2,'oferta trabajo','false');

insert into missatges_adreçes
values
(1,1,5,'to'),
(2,2,5,'to'),
(3,3,4,'to'),
(4,4,4,'cc'),
(5,4,5,'to');