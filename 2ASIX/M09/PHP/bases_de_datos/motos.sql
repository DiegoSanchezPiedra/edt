CREATE DATABASE motos;
use motos;
CREATE TABLE modelos(
    id_modelo serial NOT NULL,
    modelo varchar(255) NOT NULL,
    tipo varchar (255) NOT NULL,
    precio int NOT NULL,
    PRIMARY KEY (id_modelo)
);

CREATE TABLE marcas(
    id_marca serial NOT NULL,
    marca varchar(255) NOT NULL,
    pais varchar(255) NOT NULL,
    anyo int NOT NULL,
    PRIMARY KEY (d_marca)
);

INSERT INTO motos (modelo,tipo,precio) VALUES 
('kawasaki ninja 300','semideportiva','5000'),
('kawasaki z900','naked','9000'),
('vespa 125 abs','scooter','4000'),
('harley davidson iron 883','custom','11000');

INSERT INTO marcas (marca,pais,anyo) VALUES
('kawasaki','Japon',1950),
('Vespa','España',1960),
('harley','Estados Unidos',1980);