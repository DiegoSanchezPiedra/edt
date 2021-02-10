#K20 kerberos server

@edt ASIX M11-SAD Curs 2020 - 2021

### Autenticació

 * **edtasixm11/k20:server** Servidor keberos detach. Crea els usuaris pere pau (admin), jordi, anna, marta, marta/admin i julia. Assignar-li el nom de host: kserver.edt.org

* **isx2031424/k20:khost** host client de kerberos. simplement amb eines kinit, klist i kdestroy (no pam)

* engegar el ldap **docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -d edtasixm06/ldap20:latest**

* engegar el host client de khost-pam-ldap:

'''
docker run --rm --name khost-pam-ldap -h khost-pam-ldap --net 2hisix -it isx2031424/k20:khost-pam-ldap
'''
