--diego sanchez piedra
--isx2031424

lab_clinic=# \d pacients
                                        Table "public.pacients"
  Column   |         Type          | Collation | Nullable |                   Default                   
-----------+-----------------------+-----------+----------+---------------------------------------------
 idpacient | integer               |           | not null | nextval('pacients_idpacient_seq'::regclass)
 nom       | character varying(15) |           | not null | 
 cognoms   | character varying(30) |           | not null | 
 dni       | character varying(9)  |           |          | 
 data_naix | date                  |           | not null | 
 adreca    | character varying(50) |           | not null | 
 ciutat    | character varying(30) |           | not null | 
 c_postal  | character varying(10) |           | not null | 
 telefon   | character varying(9)  |           | not null | 
 email     | character varying(30) |           | not null | 
 num_ss    | character varying(12) |           |          | 
 num_cat   | character varying(20) |           |          | 
 nie       | character varying(20) |           |          | 
 passaport | character varying(20) |           |          | 
 sexe      | integer               |           |          | 
Indexes:
    "pacients_pkey" PRIMARY KEY, btree (idpacient)
Referenced by:
    TABLE "analitiques" CONSTRAINT "fk_idpacient" FOREIGN KEY (idpacient) REFERENCES pacients(idpacient) ON UPDATE CASCADE
------------------------------------------------------------------------------------------------------------------------------------------
lab_clinic=# \d provestecnica
                                                 Table "public.provestecnica"
      Column      |            Type             | Collation | Nullable |                        Default                        
------------------+-----------------------------+-----------+----------+-------------------------------------------------------
 idprovatecnica   | integer                     |           | not null | nextval('provestecnica_idprovatecnica_seq'::regclass)
 idprova          | integer                     |           | not null | 
 dataprova        | timestamp without time zone |           | not null | 
 resultat_numeric | boolean                     |           | not null | true
 minpat           | double precision            |           | not null | 
 maxpat           | double precision            |           | not null | 
 minpan           | double precision            |           | not null | 
 maxpan           | double precision            |           | not null | 
 resultat_cadena  | text                        |           |          | 'n'::text
 sexe             | integer                     |           | not null | 0
 edat_inical      | integer                     |           | not null | 0
 edat_final       | integer                     |           | not null | 999
Indexes:
    "provestecnica_pkey" PRIMARY KEY, btree (idprovatecnica, idprova, sexe, edat_inical, edat_final)
Foreign-key constraints:
    "fk_idprova" FOREIGN KEY (idprova) REFERENCES catalegproves(idprova) ON UPDATE CASCADE

------------------------------------------------------------------------------------------------------------------------------------------
lab_clinic=# \d catalegproves
                       Table "public.catalegproves"
     Column      |          Type          | Collation | Nullable | Default 
-----------------+------------------------+-----------+----------+---------
 idprova         | integer                |           | not null | 
 nom_prova       | character varying(15)  |           | not null | 
 descripcio      | character varying(100) |           | not null | 
 acronim         | character varying(15)  |           |          | 
 info_autoritats | boolean                |           | not null | false
Indexes:
    "catalegproves_pkey" PRIMARY KEY, btree (idprova)
Referenced by:
    TABLE "provestecnica" CONSTRAINT "fk_idprova" FOREIGN KEY (idprova) REFERENCES catalegproves(idprova) ON UPDATE CASCADE
