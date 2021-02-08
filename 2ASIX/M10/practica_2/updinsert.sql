CREATE OR REPLACE FUNCTION updinsert()
RETURNS text AS
$$
DECLARE
 	result varchar := '';
 	searchsql varchar := '';
	count_existe varchar := 0;
 	pacient_nou record;
BEGIN
 	searchsql := 'SELECT idpacient from nous_pacients';
	FOR pacient_nou IN EXECUTE(searchsql) LOOP
        EXECUTE 'select count(*) from pacients where idpacient=(select idpacient from nous_pacients where idpacient=' || pacient_nou ||');' into count_existe;
		
        IF count_existe != '1'
		THEN
            raise notice '% - % - insert',pacient_nou,count_existe;
            EXECUTE 'INSERT INTO pacients select * from nous_pacients where idpacient=' || pacient_nou ||';';
        ELSE
            raise notice '% - % - update',pacient_nou,count_existe;
            EXECUTE 'update pacients 
			set 
            pacients.idpacient = (select idpacient from nous_pacients where idpacient=' || pacient_nou ||'),
			pacients.nom = (select nom from nous_pacients where idpacient=' || pacient_nou ||'),
			pacients.cognoms = (select cognoms from nous_pacients where idpacient=' || pacient_nou ||'),
			pacients.dni = (select dni from nous_pacients where idpacient=' || pacient_nou ||'),
			pacients.data_naix = (select data_naix from nous_pacients where idpacient='  || pacient_nou ||'),
			sexe = (select sexe from nous_pacients where idpacient=' || pacient_nou ||'),
			adreca = (select adreca from nous_pacients where idpacient=' || pacient_nou || '),
			ciutat = (select ciutat from nous_pacients where idpacient=' || pacient_nou || '),
			c_postal = (select c_postal from nous_pacients where idpacient=' || pacient_nou || '),
			telefon = (select telefon from nous_pacients where idpacient=' || pacient_nou || '),
			email = (select email from nous_pacients where idpacient=' || pacient_nou || '),
			num_ss = (select num_ss from nous_pacients where idpacient=' || pacient_nou || '),
			num_cat = (select num_cat from nous_pacients where idpacient=' || pacient_nou || '),
			nie = (select nie from nous_pacients where idpacient=' || pacient_nou || '),
			passaport = (select passaport from nous_pacients where idpacient=' || pacient_nou || ')
			where idpacient=(select idpacient from nous_pacients where idpacient=' || pacient_nou || ');';
		END IF;
 	
	 	END LOOP;

END;
$$
LANGUAGE 'plpgsql' VOLATILE;

--insert nou
insert into nous_pacients 
values 
(4,'diego','sanchez',NULL,'2000-03-17','H','casa','bcn','08014','603329923','diego@edt.org',NULL,NULL,'y2031424d',NULL);

insert into pacients select * from nous_pacients where idpacient = 4;

--update pacient existent ja
insert into nous_pacients values (1,'jose','remar silva',NULL,'1996-07-12','M','veciana 8 2 2','barcelona','08023','989856565','jose@mail.com',NULL,NULL,'a123456b',NULL);
--canvia de dni a nie


update pacients 
set 
idpacient = (select idpacient from nous_pacients where idpacient=1),
nom = (select nom from nous_pacients where idpacient=1),
cognoms = (select cognoms from nous_pacients where idpacient=1),
dni = (select dni from nous_pacients where idpacient=1),
data_naix = (select data_naix from nous_pacients where idpacient=1),
sexe = (select sexe from nous_pacients where idpacient=1),
adreca = (select adreca from nous_pacients where idpacient=1),
ciutat = (select ciutat from nous_pacients where idpacient=1),
c_postal = (select c_postal from nous_pacients where idpacient=1),
telefon = (select telefon from nous_pacients where idpacient=1),
email = (select email from nous_pacients where idpacient=1),
num_ss = (select num_ss from nous_pacients where idpacient=1),
num_cat = (select num_cat from nous_pacients where idpacient=1),
nie = (select nie from nous_pacients where idpacient=1),
passaport = (select passaport from nous_pacients where idpacient=1)
where idpacient=(select idpacient from nous_pacients where idpacient=1);