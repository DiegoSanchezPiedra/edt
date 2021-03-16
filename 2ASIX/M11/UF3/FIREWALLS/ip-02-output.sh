#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/ipv4/ip_forward

# Regles flush
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#el nostre ordinador pot accedir al port 2013 de tots el hosts excepte del host i03
iptables -A OUTPUT -p tcp --dport 2013 -d 10.200.243.203 -j REJECT
iptables -A OUTPUT -p tcp --dport 2013 -j ACCEPT

#permetre accedir al port 13 de qualsevol destí
iptables -A OUTPUT -p tcp --dport 13 -d 0.0.0.0/0 -j ACCEPT

# Polítiques per defecte: 
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 10.200.243.205 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.205 -j ACCEPT

