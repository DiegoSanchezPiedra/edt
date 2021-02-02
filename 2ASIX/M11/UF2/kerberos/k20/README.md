#kerberos
##@edt curs 2020-2021
##isx2031424
##Diego Sanchez

* **isx2031424/k20:kserver** servidor kerberos detach. Crea els usuaris pere pau (admin), jordi, anna, marta, marta/admin i julia. Assignar-li el nom de host: kserver.edt.org

***docker run --rm --name kserver.edt.org -h kserver.edt.org --net 2hisix -d isx2031424/k20:kserver***

* **isx2031424/k20:khost** host client de kerberos. Simplement amb eines kinit, klist i kdestroy (no pam). El servidor al que contacta s'ha de dir kserver.edt.org

***docker run --rm --name khostedt.org -h khost.edt.org --net 2hisix -it isx2031424/k20:khost***
