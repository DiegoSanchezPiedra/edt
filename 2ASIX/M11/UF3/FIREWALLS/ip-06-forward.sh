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
#--#iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.0/24 -j REJECT

#no permetre de netA accedir al host B1
#--#iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.2 -j REJECT

#host A1 no pot accedir a res de B1
#--#iptables -A FORWARD -s 172.19.0.02 -d 172.20.0.2 -j REJECT

#netA te betat accedir al port 13 d'on sigui
	#per ip
#--#iptables -A FORWARD -s 172.19.0.0/24 -p tcp --dport 13 -j REJECT
	#per interficie
#--#iptables -A FORWARD -i br-0efae8ee93e7 -p tcp --dport 13 -j REJECT

#la netA no pot accedir al port 2013 de la netB
#--#iptables -A FORWARD -s 172.19.0.0/24 -d 172.20.0.0/24 -p tcp --dport 2013 -j REJECT

#la netA pot navegar per intenet, però no pot fer res més a l'exterior
iptables -A FORWARD -s 172.19.0.0/24 -p tcp --dport 80 -o enp0s31f6 -j ACCEPT
iptables -A FORWARD -d 172.19.0.0/24 -p tcp --sport 80 -i enp0s31f6 -m state --state RELATED,ESTABLISHED -j ACCEPT
		#No cal que posem el -j MASQUERADE ja que la tenim posada abans i ja s'encarrega de fer el MASQUERADE
#iptables -A FORWARD -s 172.19.0.0/24 -o enp0s31f6 -j DROP
#iptables -A FORWARD -d 172.19.0.0/24 -i enp0s31f6 -j DROP

#netA pot accedir al port 2013 de totes les xarxes d'internet excepte la xarxa local(192.168.1.0/24)
iptables -A FORWARD -p tcp -s 172.19.0.0/24 -d 192.168.1.0/24 --dport 2013 -o enp0s31f6 -j REJECT
iptables -A FORWARD -s 172.19.0.0/24 -p tcp --dport 2013 -o enp0s31f6 -j ACCEPT

#evitar que es falsifiqui la ip de origen: SPOOFING
iptable -A FORWARD ! -s 172.19.0.0/24 -i br-0efae8ee93e7 -j DROP #tot que el provingui de la interficie de la netA que no sigui una ip de la netA no l'acceptis
