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
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 192.168.0.15 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.15 -j ACCEPT

# Fer NAT per les xarxes internes:
# - 172.19.0.0/24
# - 172.20.0.0/24
iptables -t nat -A POSTROUTING -s 172.19.0.0/24 -o enp0s31f6 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.20.0.0/24 -o enp0s31f6 -j MASQUERADE

#no permetre xarxa A accedir al host xaxa B
iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.0/24 -j REJECT

#no permetre de netA accedir al host B1
iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.2 -j REJECT
