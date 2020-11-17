# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Diego Sanchez Piedra

- Tipus mdb, passwd xifrat secret i un unic fitxer ldif
- nou schema afegit de master.schema amb els seus atributs 

**Detach**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d isx2031424/ldap20:practica`

**Interactiu**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -it isx2031424/ldap20:practica /bin/bash`
