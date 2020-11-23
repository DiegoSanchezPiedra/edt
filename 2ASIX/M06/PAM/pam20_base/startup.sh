#! /bin/bash
cp -rf /opt/docker/login.defs /etc/login.defs
useradd unix01
echo "unix01" | passwd --stdin unix01
useradd unix02
echo "unix02" | passwd --stdin unix02
useradd unix03
echo "unix03" | passwd --stdin unix03
/bin/bash
