#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/ipv4/ip_forward

# Regles flush
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#---------------------------------
#Exemples de regles input
#---------------------------------

#barrera final de ports (ull! quedar tancat)
#iptables -A INPUT -p tcp --dport 1:1024 -j REJECT


#xapar tots els ports del 3000:8000
#iptables -A INPUT -p tcp --dport 3000:8000 -j REJECT


#port 80 obert a tothom
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

#port 80 xapat a tothom
iptables -A INPUT -p tcp --dport 2013 -j REJECT

#port 3013 xapat per a un host concret i obert a tothom
iptables -A INPUT -p tcp --dport 3013 -s 10.200.243.228 -j REJECT
iptables -A INPUT -p tcp --dport 3013 -j ACCEPT

#port 4013 tacat a tothom i obert per un host
iptables -A INPUT -p tcp --dport 4013 -s 10.200.243.228 -j ACCEPT
iptables -A INPUT -p tcp --dport 4013 -j REJECT

#port 5013 esta tacat a tothom, obert a xarxa n2j i tancat a un host de la xarxa anterior
iptables -A INPUT -p tcp --dport 5013 -s 10.200.243.228 -j REJECT
iptables -A INPUT -p tcp --dport 5013 -s 10.200.243.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 5013 -j ACCEPT

#port 6013 obert a tothom, tancat a l'aula n2j i obert al i28(10.200.243.228)
iptables -A INPUT -p tcp --dport 6013 -s 10.200.243.228 -j ACCEPT
iptables -A INPUT -p tcp --dport 6013 -s 10.200.243.0/24 -j DROP
iptables -A INPUT -p tcp --dport 6013 -j ACCEPT

#-------------------------------+
# Polítiques per defecte: 	|
#-------------------------------+
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

