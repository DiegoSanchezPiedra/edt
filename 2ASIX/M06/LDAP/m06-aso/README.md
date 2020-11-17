LDAP @edt ASIX M06-ASO

Curs 2020 - 2021

isx2031424/ldap20:base :
Imatge base de un servidor ldap que funciona amb detach. carrega edt.org, els elements bàsics i els usuaris bàsics.

isx2031424/ldap20:editat :
Imatge d'un servidor ldap que funciona amb mode interactiu i mode detach. càrrega la base de dades edt.org, té els tres fitxers .ldif unificats en un.

isx2031424/ldap20:acl :
Imatge d'un servir ldap que funciona amb mode interactiu i mode detach, càrrega la base de dades edt.org, té diferents directius ACL que el antics.

isx2031424/ldap20:schema:
Imatge d'un servidor ldap que funciona en mode detach i interactiu, càrrega la base de dades edt.org, té un nou objectclass afegit i atributs nous.

isx2031424/phpldadadmin:20 :
Imatge amb un servidor phpldapadmin. Connecta a al servidor ldap
  anomenat *ldap.edt.org* per accedir a les bases de dades *dc=edt,dc=org* i *cn=config*. Aquesta imatge
  està basada en fedora:27 per evitar el canvi de sintaxis de PHP 7.4

isx2031424/ldap20:group :
Imatge d'un servidor ldap  que funciona amb mode interactiu i detach, càrrega la base de dades edt.org, té modificacions en el .ldif com la creació de nou grups i els seus members, també instal·la només els paquets openldap-server i openldap-clients.
