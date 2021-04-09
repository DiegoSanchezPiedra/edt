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
iptables -P FORWARD DROP
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 192.168.0.15 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.15 -j ACCEPT

#NAT
# 172.21.0.0/24
# 172.22.0.0/24
# 10.10.10.0/24
iptables -t nat -A POSTROUTING -s 172.21.0.0/24 -o enp0s31f6 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.22.0.0/24 -o enp0s31f6 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o enp0s31f6 -j MASQUERADE

#des de la netA es pot accedir al servidor web de la dmz
#iptables -A FORWARD -s 172.21.0.0/24 -d 10.10.10.2 -p tcp --dport 80 -j ACCEPT
#iptables -A FORWARD -s 10.10.10.2 -d 172.21.0.0/24 -p tcp --sport 80 -m state --state ESTABLISHED,RELATED -j ACCEPT
#iptables -A FORWARD -s 0.0.0.0/0 -d 10.10.10.2 -p tcp --dport 80 -j REJECT

#permetre accés exterior al DNS
iptables -A FORWARD -o enp0s31f6 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -i enp0s31f6 -p udp --sport 53 -j ACCEPT
iptables -A FORWARD -o enp0s31f6 -p tcp --dport 53 -j ACCEPT
iptables -A FORWARD -i enp0s31f6 -p tcp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT

#que la xarxa B pot navegar per internet
iptables -A FORWARD -s 172.22.0.0/24 -d 0.0.0.0/0 -o enp0s31f6 -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -s 0.0.0.0/0 -i enp0s31f6 -d 172.22.0.0/24 -p tcp --sport 80 -m state --state RELATED,ESTABLISHED -j ACCEPT

#des de la xarxa A es pot accedir a la xarxa B
iptables -A FORWARD -s 172.21.0.0/24 -d 172.22.0.0/24 -j ACCEPT
# b->a xapar icmp
# b->a xapar udp ?? com??
iptables -A FORWARD -s 172.22.0.0/24 -d 172.21.0.0/24 -p udp -m state --satate ESTABLISHED -j ACCEPT
# b->a xapar el que no sigui tcp resposta
iptables -A FORWARD -s 172.22.0.0/24 -d 172.21.0.0/24 -j ACCEPT

#https://serverfault.com/questions/123208/iptables-p-udp-state-established
