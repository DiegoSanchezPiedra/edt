# LDAP Server
@edt ASIX M06-ASO
Servidor LDAP

servidor LDAP per fer proves de directives ACL
#executar en mode interactiu
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -it 
isx2031424/ldap:acl /bin/bash

#executar en una altra consola en mode interactiu
docker exec -it "cointainerName" /bin/bash

#executar en mode detach
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -d isx2031424/ldap:acl

Exemples:
access to * by * read
access to * by * write

access to * by self write by * read
/
acces to *
      by self write
      by * read
