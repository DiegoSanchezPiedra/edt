#K20 kerberos server

@edt ASIX M11-SAD Curs 2020 - 2021

### Autenticació
* **isx2031424/k20:sshd** server ssh que fa servir l'auntenticació per kerberos, aquest cop es farà servir authconfig

'''
docker run --rm --name kserver.edt.org -h kserver.edt.org -p 88:88 -p 464:464 -p 749:749 -p 2022:22 --net 2hisix -d isx2031424/k20:kserver
'''
