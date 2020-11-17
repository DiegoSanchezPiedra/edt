# LDAP Server
## @edt ASIX M06-ASO Curs 2020 - 2021
### Servidor LDAP

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona

Imatge:

* **edtasixm06/ldap20:practica** Practica amb schema Master
  Afegeix a la base de dades un achema per saber si els usuaris han fet o no un master.
  També afegeix a dos dels usuaris existents un master, i crea un nou
  usuari Ramon que té un master.

```
attributetype ( 1.1.2.1.1 NAME 'x-famaster'
  DESC 'true/false fa el master'
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.7
  SINGLE-VALUE)

attributetype ( 1.1.2.1.2 NAME 'x-nommaster'
  DESC 'Nom del master'
  EQUALITY caseIgnoreMatch
  SUBSTR caseIgnoreSubstringsMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{50}
  SINGLE-VALUE)

attributetype ( 1.1.2.1.3 NAME 'x-notamaster'
  DESC 'nota del master'
  EQUALITY integerMatch
  ORDERING integerOrderingMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.27
  SINGLE-VALUE)

attributetype ( 1.1.2.1.4 NAME 'x-webmaster'
  DESC 'web del master'
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.26)

attributetype ( 1.1.2.1.5 NAME 'x-fotoalum'
  DESC 'Foto del alumne'
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.28)

attributetype ( 1.1.2.1.6 NAME 'x-docum'
  DESC 'Documentacio a presentar'
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.5)

objectclass ( 1.1.2.2.1 NAME 'x-master'
  DESC 'masters de la practica de schema'
  SUP top
  AUXILIARY
  MUST ( x-nommaster $ x-famaster )
  MAY ( x-notamaster $ x-webmaster $ x-fotoalum $ x-docum )
  )
```



Detach:
Observeu que s'insereixen les dades amb una ordre docker exec (per exemple)
```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -d edtasixm06/ldap20:practica 

docker exec -it ldap.edt.org ldapadd -vx -h localhost -D 'cn=Manager,dc=edt,dc=org' -w secret -f add-masters.ldif
```



