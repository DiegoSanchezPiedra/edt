# LDAP Server
## @edt ASIX M06-ASO Curs 2020 - 2021
### Servidor LDAP

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona

Imatge:

* **edtasixm06/ldap20:group** Imatge amb usuaris identificats pel uid
  per exemple uid=pere,ou=usuaris,dc=edt,dc=org. S0han afegit grups dins de una
  ou=grups que conté els grups, i s'hi han posat els usuaris.


```
dn: ou=grups,dc=edt,dc=org
ou: grups
description: Container per a grups del sistema linux
objectclass: organizationalunit
```

```
dn: cn=professors,ou=grups,dc=edt,dc=org
objectclass: posixGroup
cn: professors
gidNumber: 601
description: Grup de professors
memberUid: pau
memberUid: pere
memberUid: jordi
```

Detach:
```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -d edtasixm06/ldap20:group
```



