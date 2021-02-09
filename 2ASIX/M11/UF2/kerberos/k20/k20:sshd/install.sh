#! /bin/bash
#khost-pam
#edt asix m11 SAD curs 2020 - 2021

cp /opt/docker/krb5.conf /etc/krb5.conf
bash /opt/docker/auth.sh
/usr/bin/ssh-keygen -A
cp /opt/docker/sshd_config /etc/ssh/sshd_config
#cp /opt/docker/nslcd.conf /etc/nslcd.conf
#cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
#cp /opt/docker/nsswitch.conf /etc/nsswitch.conf

#cp /opt/docker/system-auth /etc/pam.d/system-auth

kadmin -p admin -w kadmin -q "ktadd -k /etc/krb5.keytab host/sshd.edt.org"

#crear usuaris local01..03 (IP + AP)
for user in local{01..03}
do
	useradd $user
	echo -e "$user\n$user" | passwd --stdin $user
done

#crear usuaris kuser{01..03} (IP) el AP es el kerberos
for user in kuser{01..06}
do
        useradd $user
done

