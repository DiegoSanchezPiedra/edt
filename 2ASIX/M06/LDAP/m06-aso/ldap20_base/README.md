# LDAP Server
@edt ASIX M06-ASO
Servidor LDAP

#executar en mode interactiu
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -h 389:389 -it
isx2031424/ldap20:base /bin/bash

#executar en mode detach
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -h 389:389 -d
isx2031424/ldap20:base
