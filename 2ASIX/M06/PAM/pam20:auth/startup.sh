#! /bin/bash
#crear els usuaris locals
useradd unix01
echo "unix01" | passwd --stdin unix01
useradd unix02
echo "unix02" | passwd --stdin unix02
useradd unix03
echo "unix03" | passwd --stdin unix03

authconfig --savebackup unix
bash auth.sh

#cp /opt/docker/ldap.conf /etc/openldap/ldap.con
#cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
#cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/system-auth /etc/pam.d/system-auth-ac
cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
authconfig --savebackup ldap

#/sbin/nscd
/sbin/nslcd

/bin/bash
