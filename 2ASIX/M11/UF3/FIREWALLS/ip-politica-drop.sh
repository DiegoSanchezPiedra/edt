#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/ipv4/ip_forward

# Regles flush
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Polítiques per defecte: 
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 10.200.243.204 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.204 -j ACCEPT

#dns
iptables -A OUTPUT -p tcp -s 10.200.243.204 --dport 53 -j ACCEPT
iptables -A INPUT -p tcp -d 10.200.243.204 --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p udp -s 10.200.243.204 --dport 53 -j ACCEPT
iptables -A INPUT -p udp -d 10.200.243.204 --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT

#dhclient (el cliente escucha por el puerto 67 y el servidor por el 68)
iptables -A OUTPUT -p udp -s 10.200.243.204 --dport 68 -j ACCEPT
iptables -A INPUT -p udp -d 10.200.243.204 --sport 68 -m state --state RELATED,ESTABLISHED -j ACCEPT

#ssh 
iptables -A OUTPUT -p tcp -s 10.200.243.204 --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -d 10.200.243.204 --sport 22 -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m state --state RELATED,ESTABLISHED -j ACCEPT

