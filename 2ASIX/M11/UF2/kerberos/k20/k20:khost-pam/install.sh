#! /bin/bash
#khost-pam
#edt asix m11 SAD curs 2020 - 2021

cp /opt/docker/krb5.conf /etc/krb5.conf

#crear usuaris local01..03 (IP + AP)
for user in local{01..03}
do
	useradd $user
	echo -e "$user\n$user" | passwd --stdin $user
done

#crear usuaris kuser{01..03} (IP) el AP es el kerberos
for user in kuser{01..03}
do
        useradd $user
done

#posar el system auth amb el pam_krb5.so
cp /opt/docker/system-auth /etc/pam.d/system-auth
