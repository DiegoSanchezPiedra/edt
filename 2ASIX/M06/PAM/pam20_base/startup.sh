#! /bin/bash
cp -rf /opt/docker/login.defs /etc/login.defs
useradd anna
echo "anna" | passwd --stdin anna
useradd pere
echo "pere" | passwd --stdin pere
useradd pau
echo "pau" | passwd --stdin pau
/bin/bash
