# Criptografia
* Simetrica --> secret compartit, claus curtes nº bits, algorisme ràpid
* Asimètrica --> clau publica/privada, llarg \ bits, algorismes passats
* Hibrida --> Asimètrica per establiment i negociació de secret compartit, data on motion amd simètrica
* Web of Trust --> Cada usuari decideix amb quin confia
* PKI --> Public Key Infrastructure 

# Certificats Digitals / TLS

### Certificats
* No són la clau pública 
'''
	--> clau privada	(2*3=6)
	--> clau publica	(he fet servir un 3)

	Certificat de pere
	     --> clau publica	(3)
	     --> ID pere Subject (qui demana el certificat)	(cn=pere,ou=... X509) dn --> cn
	*El que és important és el cn*
	     --> ID issuer (qui emet el certificat)
	     --> Firma del Issuer (firmat amb la clau privada del Issuer)

	Trust / Validesa de qui firma --> CA
	
	CA Certificate Authority / piramidal / jeràrquica / múltiples arrels
		CA generalitat		//	gobierno españa		// 	CA verisig
		  CA dept ensenyament	//	CA hacienda
			delegades


		CA edt.org

		Existeixen CAs autoritats, CA internet, CAs organitzacions
'''

### TLS

* Data at motion usem certificats degitals (híbrida)
* HTTPS, ldaps, pops, imaps, smtps -> SSL/TLS

	* servidor --> certificat de servidor
	* Client --> certificat de client

claus privades:
* RSA
* DSA

formats dels fitxers:
* ASCII -> format DER
* pem (base 64)

Des3 algorisme simètric usat amb una passfrasse per protegir la calu privada
Si s'ultilitza el fitxer no conté la clau sino la clau xifrada
per usar la clau cada vegada cal desbloquejar-la amb la passfrase

-----------------------------------------------------------------------------------

Certificats autosignats:	
	* autosignat
	* els que firma una CA
		* Per ser una CA

	x509 -> certificat
	req -> petició del certificació

-----------------------------------------------------------------------------------

Web Server: key.pem cert.pem autosignat

CA Certificate Authority
	Veritat Absoluta CA <--- autosignat
			Web Server => web.edt.org <- certificat avalat per la cA
			* clau privada
		<----	* pubkey + ID subject dades + firma privada = request

			CA  =>
			verifica la identitat
			Certificat:
			  req + signar + les dades del issuer
