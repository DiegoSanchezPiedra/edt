#! /bin/bash

/opt/docker/install.sh && echo "OK install"
/sbin/nscd && echo "ok nscd"
/sbin/nslcd && echo "ok nslcd"
/usr/sbin/sshd -D
