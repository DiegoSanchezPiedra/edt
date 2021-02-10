#kerberos
##@edt curs 2020-2021
##isx2031424
##Diego Sanchez

* **isx2031424/k20:kserver** servidor kerberos detach. Crea els usuaris pere pau (admin), jordi, anna, marta, marta/admin i julia. Assignar-li el nom de host: kserver.edt.org

***docker run --rm --name kserver.edt.org -h kserver.edt.org --net 2hisix -d isx2031424/k20:kserver***

* **isx2031424/k20:khost** host client de kerberos. Simplement amb eines kinit, klist i kdestroy (no pam). El servidor al que contacta s'ha de dir kserver.edt.org

***docker run --rm --name khostedt.org -h khost.edt.org --net 2hisix -it isx2031424/k20:khost***

* **isx2031424/k20:khost-pam** Host client de kerberes amb usaris kusers que es poden identificar amb kerveros per mig de pam

***docker run --rm --name khost-pam.edt.org -h khost-pam.edt.org --net 2hisix -it isx2031424/k20:khost-pam***
###Per engegar el kserver a una AMI d'Amazon:
* propagació de ports 88 464 749
* obrir els mateixos ports al security group
* afegir en el /etc/hosts del client la ip de aws i el domanin name: **A.B.C.D kserver.edt.org kserver**

'''
docker run --rm --name khost-pam-ldap -h khost-pam-ldap --net 2hisix -d isx2031424/k20:khost-pam-ldap
'''

* **isx2031424/k20:khost-pam-ldap** host client de keberos i ldap
autentica usuaris contra aquests dos serveis:

'''
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisix -p 389:389 -d edtasixm06/ldap20:latest
'''

'''
docker run --rm --name kserver.edt.org -h kserver.edt.org -p 88:88 -p 464:464 -p 749:749 --net 2hisix -d isx2031424/k20:kserver
'''

* **isx2031424/k20:sshd** server ssh que fa servir l'auntenticació per kerberos, aquest cop es farà servir authconfig

'''
docker run --rm --name sshd.edt.org -h sshd.edt.org --net 2hisix -p 22:22 -d isx2031424/k20:sshd
'''
