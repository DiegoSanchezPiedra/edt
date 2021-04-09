--Diego Sanchez Piedra
--isx2031424
DROP DATABASE IF EXISTS motos;
CREATE DATABASE motos;
use motos;

CREATE TABLE motos(
    id_modelo serial NOT NULL PRIMARY KEY,
    modelo varchar(255) NOT NULL,
    marca varchar(255) NOT NULL,
    tipo varchar (255) NOT NULL,
    precio int NOT NULL
);

INSERT INTO motos (modelo,marca,tipo,precio) VALUES 
('kawasaki ninja 300','kawasaki','semideportiva','5000'),
('kawasaki z900','kawaski','naked','9000'),
('vespa 125 abs','vespa','scooter','4000'),
('harley davidson iron 883','harley','custom','11000');