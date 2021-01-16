CREATE TABLE "clientes" (
	"num_clie" int2 NOT NULL,
	"empresa" varchar(20) NOT NULL,
	"rep_clie" int2 NOT NULL,
	"limite_credito" numeric(8,2),
	PRIMARY KEY (num_clie)
);
REVOKE ALL on "clientes" from PUBLIC;
GRANT SELECT on "clientes" to PUBLIC;

CREATE TABLE "productos" (
	"id_fab" character(3) NOT NULL,
	"id_producto" character(5) NOT NULL,
	"descripcion" character varying(20) NOT NULL,
	"precio" numeric(7,2) NOT NULL,
	"existencias" int4 NOT NULL,
	PRIMARY KEY (id_fab,id_producto)
);
REVOKE ALL on "productos" from PUBLIC;
GRANT SELECT on "productos" to PUBLIC;

CREATE TABLE "repventas" (
	"num_empl" int2 NOT NULL,
	"nombre" character varying(15) NOT NULL,
	"edad" int2,
	"oficina_rep" int2,
	"titulo" character varying(10),
	"contrato" date NOT NULL,
	"director" int2,
	"cuota" numeric(8,2),
	"ventas" numeric(8,2) NOT NULL,
	PRIMARY KEY (num_empl)
);
REVOKE ALL on "repventas" from PUBLIC;
GRANT SELECT on "repventas" to PUBLIC;

CREATE TABLE "oficinas" (
	"oficina" int2 NOT NULL,
	"ciudad" character varying(15) NOT NULL,
	"region" character varying(10) NOT NULL,
	"dir" int2,
	"objetivo" numeric(9,2),
	"ventas" numeric(9,2) NOT NULL,
	PRIMARY KEY (oficina)
);
REVOKE ALL on "oficinas" from PUBLIC;
GRANT SELECT on "oficinas" to PUBLIC;

CREATE TABLE "pedidos" (
	"num_pedido" int4 NOT NULL,
	"fecha_pedido" date NOT NULL,
	"clie" int2 NOT NULL,
	"rep" int2,
	"fab" character(3) NOT NULL,
	"producto" character(5) NOT NULL,
	"cant" int2 NOT NULL,
	"importe" numeric(7,2) NOT NULL,
	PRIMARY KEY (num_pedido)
);
REVOKE ALL on "pedidos" from PUBLIC;
GRANT SELECT on "pedidos" to PUBLIC;
