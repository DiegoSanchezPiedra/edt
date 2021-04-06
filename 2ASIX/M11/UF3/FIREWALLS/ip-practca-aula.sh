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
iptables -A INPUT -s 10.200.243.205 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.205 -j ACCEPT
iptables -A INPUT -s 172.200.20.1 -j ACCEPT
iptables -A OUTPUT -s 172.200.20.1 -j ACCEPT

# No es permet que els hosts de l’exterior (externs a l’organització) accedeixin al
#servei daytime del router/firewall.
#Observar que des dels hosts A i B si és permet aquest accés. Perquè?

	#Tamcar també l’accés del host B al servei daytime del router/firewall. Observar que el
	#host A encara ha de poder accedir al servei daytime del router/firewall.
iptables -A INPUT -p tcp --dport 13 -s 172.200.20.3 -j REJECT

iptables -A INPUT -p tcp --dport 13 -s 172.200.20.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 13 -s 0.0.0.0/0 -j REJECT

#Des del router/firewall no es permet accés a cap serveu daytime exterior (extern a
#l’organització).
#Observeu que això no impedeix que des dels hosts A i B si que es pot accedir a
#aquest servei.
iptables -A OUTPUT -p tcp --dport 13 -d 172.200.20.0/24 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 13 -d 0.0.0.0/0 -j REJECT

#Implementar NATde la xarxa interior. Verificar que els hosts A i B tenen connectivitat
#amb serveis externs.
iptables -t nat -A POSTROUTING -s 172.200.20.0/24 -o enp5s0 -j MASQUERADE

#No es permet que el host A pugui accedir a serveis web (80) de l’exterior (externs a
#l’organització). Observar que si pot accedir al servei web de B i del router/firewall.
iptables -A FORWARD -p tcp --dport 80 -s 172.200.20.2 -j REJECT
###iptables -A FORWARD -p tcp --dport 80 -s 172.200.20.0/24 -j ACCEPT

#Permetre explícitament que el host B pugui accedir a serveis web de l’exterior i del
#router/firewall.
iptables -A FORWARD -p tcp --dport 80 -s 172.200.20.3 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -s 172.200.20.3 -j ACCEPT

#Configurar el port 2022 del router/firewall per accedir al servei ssh del host A.
iptables -t nat -A PREROUTING -p tcp --dport 2022 -j DNAT --to 172.200.20.2:22
#iptables -t nat -A PREROUTING -p tcp --dport 2013 -j DNAT --to 172.200.20.2:13

#Configurar el port 2013 del router/firewall per accedir al port 13 del host B.
iptables -t nat -A PREROUTING -p tcp --dport 3013 -j DNAT --to 172.200.20.3:13

#Configurar el port 2080 del router/firewall per accedir al servei web del host A.
#*Nota: observeu que en tots tres casos a part de la configuració del port forwardinf
#cal la corresponent configuració de forwarding.
iptables -t nat -A PREROUTING -p tcp --dport 2080 -j DNAT --to 172.200.20.2:80
