#!/bin/bash
#isx2031424
#diego sanchez 
#@edt 2hisx
#===================
#1.
iptables -F 
iptables -X
iptables -Z
iptables -t nat -F

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -t nat -P PREROUTING DROP
iptables -t nat -p POSTROUTNG DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -s 10.200.243.205 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.205 -j ACCEPT

iptables -A INPUT -s 172.20.0.1 -j ACCEPT
iptables -A OUTPUT -d 172.20.0.1 -j ACCEPT

iptables -A INPUT -s 172.30.0.1 -j ACCEPT
iptables -A OUTPUT -d 172.30.0.1 -j ACCPET

iptables -A INPUT -s 10.0.0.1 -j ACCEPT
iptables -A OUTPUT -s 10.0.0.1 -j ACCEPT

#2. Permetem fer el tràfic de FORWARD per a cada xarxa i tal de poder fer després el NAT
iptables -A FORWARD -s 172.20.0.0/16 -i dockera -o enp5s0 -j ACCEPT
iptables -A FORWARD -d 172.20.0.0/16 -i enp5s0 -o dockera -j ACCEPT
iptables -t nat -A POSTROUTING -s 172.20.0.0/16 -i dockera -o enp5s0 -j MASQUERADE

iptables -A FORWARD -s 172.30.0.0/16 -i dockerb -o enp5s0 -j ACCEPT
iptables -A FORWARD -d 172.30.0.0/16 -i enp5s0 -o dockerb -j ACCEPT
iptables -t nat -A POSTROUTING -s 172.20.0.0/16 -i dockerb -o enp5s0 -j MASQUERADE

iptables -A FORWARD -s 10.0.0.0/8 -i docker0 -o enp5s0 -j ACCEPT
iptables -A FORWARD -d 10.0.0.0/8 -i enp5s0 -o docker0 -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -i docker0 -o enp5s0 -j MASQUERADE

#3. Primer permetem el les connexions a l'exterior de l'antifitrió/router/firewall per ssh tant fent el rol der servidor com de client al host 192.168.2.1
#   i deprés prohibim les connexions ssh a l'exterior de l'anfitrió/router/firewall al altres hosts.
#rol servidor
iptables -A INPUT -p tcp --dport 22 -i enp5s0 -s 192.168.2.1 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -o enp5s0 -d 192.168.2.1 -m state --state RELATED,ESTABLISHED -j ACCEPT

#rol client
iptables -A OUTPUT -p tcp --dport 22 -o enp5s0 -d 192.168.2.1 -j ACCEPT
iptables -A INPUT -p tcp --sport22 -i entp5s0 -s 192.168.2.1 -m state --state RELATED,ESTABLISHED -j ACCEPT

#rol servidor
iptables -A INPUT -p tcp --dport 22 -i enp5s0 -s 0.0.0.0/0 -j REJECT
iptables -A OUTPUT -p tcp --sport 22 -o enp5s0 -d 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j REJECT

#rol client
iptables -A OUTPUT -p tcp --dport 22 -o enp5s0 -d 0.0.0.0/0 -j REJECT
iptables -A INPUT -p tcp --sport 22 -i enp5s0 -s 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j REJECT

#4. Primer permetem les connexions, com a servidor i com a client, del host anfitrió/router/firewall a la xarxa 192.168.2.0/24 de l'exterior
#   i després prohibim les connexions, coma servidor i coma client, del host anfitrió/router/firewall a les demés xarxes de l'exterior
#rol servidor
iptables -A INPUT -p tcp --dport 22 -i enp5s0 -s 192.168.2.0/24 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -o enp5s0 -d 192.168.2.0/24 -m state --state RELATED,ESTABLISHED -j ACCEPT

#rol client
iptables -A OUTPUT -p tcp --dport22 -o enp5s0 -d 192.168.2.0/24 -j ACCEPT
iptables -A INPUT -p tcp --sport22 -i enp5s0 -s 192.168.2.0/24 -m state --state RELATED,ESTABLISHED -j ACCEPT

#rol servidor
iptables -A INPUT -p tcp --dport 22 -i enp5s0 -s 0.0.0.0/0 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -o enp5s0 -d 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j REJECT

#rol client
iptables -A OUTPUT -p tcp --dport 22 -o enp5s0 -d 0.0.0.0/0 -j ACCEPT
iptables -A INPUT -p tcp --sport 22 -i enp5s0 -s 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j REJECT

#5. Permetem el trafic per el servidor web (port 80) de la xarxa Netmdz a l'exterior per tal de poder fer el port forwarding
#   i tanquem tot l'altre tràfic de la Netdemz a l'exterior.
iptables -A FORWARD -p tcp --dport 80 -d 10.0.0.1 -o docker0 -s 0.0.0.0/0 -i enp5s0 -j ACCEPT
iptables -A FORWARD -p tcp --sport 80 -s 10.0.0.1 -i docker0 -d 0.0.0.0/0 -o enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 10.0.0.1:80

#6. fem NAT per tal de permtre que Neta i Netb puguin accedir a l'exterior, poden atacar i rebre respostes a l'exterior, però des de l'exterior no poden atacar a Neta i Netb
iptables -A FORWARD -s 172.20.0.0/16 -i dockera -d 0.0.0.0/0 -o enp5s0 -j ACCEPT
iptables -A FORWARD -s 0.0.0.0/0 -i enp5s0 -d 172.20.0.0/16 -o dockera -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -s 172.30.0.0/16 -i dockerb -d 0.0.0.0/16 -o enp5s0 -j ACCEPT
iptables -A FORWARD -s 0.0.0.0/0 -i enp5s0 -d 172.30.0.0/16 -o dockerb -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -s 0.0.0.0/0 -i enp5s0 -d 172.20.0.0/16 -o dockera -j REJECT
iptables -A FORWARD -s 0.0.0.0/0 -i enp5s0 -d 172.30.0.0/16 -o dockerb -j REJECT

iptables -A FORWARD -s 172.20.0.0/16 -i dockera -d 0.0.0.0/16 -o enp5s0 -m state --state RELATED,ESTABLISHED -j REJECT
iptables -A FORWARD -s 172.30.0.0/16 -i dockerb -d 0.0.0.0/16 -o enp5s0 -m state --state RELATED,ESTABLISHED -j REJECT

iptables -t nat -A POSTROUTING -s 172.20.0.0/16 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.30.0.0/16 -j MASQUERADE


#7. Permtem el tràfic entre NetA i Netdmz per tal que quan l'anfitrió faci el portforwarding hi hagi tràfic entre les dues xarxes
iptables -A FORWARD -s 172.20.0.0/16 -i dockera -d 10.0.0.0/8 -o docker0 -j ACCEPT
iptables -A FORWARD -s 10.0.0.0/8 -i docker0 -d 172.20.0.0/16 -o dockera -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -t nat -A PREROUTING -p tcp --dport 25 -j DNAT --to 10.0.0.1:25

#8. El host anfitrió pot fer ping i rebre resposte, però a ell no li poden fer ping i tampoc pot enviar respostes
iptables -A OUTPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -p icmp --imcp-type 0 -j ACCEPT

iptables -A INPUT -p icmp --imcp-type 8 -j DROP
iptables -A OUTPUT -p icmp --icmp-type 0 -j DROP

#9.
#camí d'anada:
	# sortida en el host a1: 
		# a1:d1 / 192.168.2.31:80
	# entrada al router:
		# a1:d1 / 192.168.2.31:80
	# sortida del router:
		# ip_pub_router:port_router / 192.168.2.31:80
	# entrada en el host remot
		# ip_pub_router:port_rotuter / 192.168.2.31:80
#camí tornada:
	# sortida del host remot:
		# 192.168.2.31:80 / ip_pub_router:port_router
	#entrada al router
		# 192.168.2.31:80 / ip_pub_router:port_router
	#sortida del router
		# 192.168.2.31:80 / a1:p1
	#entrada al host a1
		# 192.168.2.31:80 / a1:d1
