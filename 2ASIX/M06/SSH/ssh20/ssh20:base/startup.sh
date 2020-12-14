#! /bin/bash
#crear els usuaris locals
useradd unix01
echo "unix01" | passwd --stdin unix01
useradd unix02
echo "unix02" | passwd --stdin unix02
useradd unix03
echo "unix03" | passwd --stdin unix03

#fer la configuració dels usuaris LDAP
cp opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
cp /opt/docker/system-auth /etc/pam.d/system-auth
cp /opt/docker/system-auth /etc/pam.d/password-auth

#engegar els dimonos nscd i nslcd
/sbin/nscd
/sbin/nslcd

/usr/bin/ssh-keygen -A
/sbin/sshd -D
#/bin/bash
