
imatge automatitzada per aplicar la configuracio auth-config i fer el muntatge d'un direcotori tipus tmpfs de 100MB

**isx2031424/pam20:auth** host pam per practicar *AUTH-CONFIG* amb autenticació local 
unix (*pam_unix.so*) i autenticació LDAP (*pam_ldap.so*). Utilitza el paquet 
nss-pam-ldapd. Cal configurar: *ldap.conf, nslcd, nscd, nssitch.*
L'autenticació es configura al *system-auth*

docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -d isx2031424/ldap20:latest
docker run --rm --name pam.edt.org -h pam.edt.org --net 2hisix --privileged -it isx2031424/pam20:auth
