#!/bin/bash
#prhibit l'access a tothom menys excepte a la xarxa a.b.c.d/24 menys al host a.b.c.d
iptables -A INPUT -p tcp --dport 13 -s a.b.c.d -j REJECT
iptables -A OUTPUT -p tcp --sport 13 -d a.b.c.d -m state --state RELATED,ESTABLISHED -j REJECT

iptables -A INPUT -p tcp --dport 13 -s a.b.c.d/24 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 13 -d a.b.c.d/24 -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp --dport 13 -s 0.0.0.0/0 -j REJECT
iptables -A INPUT -p tcp --sport 13 -d 0.0.0.0/0 -j REJECT

#es pot accedir a qualsevol lloc excepte corea del nord (80), a la resta del mon no
iptables -A OUTPUT -p tcp --dport 80 -d corea -j ACCEPT
iptables -A INPUT -p tcp --sport 80 -s corea -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p tcp --dport 80 -d 0.0.0.0/0 -j REJECT
iptables -A INPUT -p tcp --sport 80 -s 0.0.0.0/0 -m satate --state RELATED,ESTABLISHED -j REJECT

#el hostA1 de la xarxa A no pot accedir al servei web de la xarxaB, els demes si poden

iptables -A FORWARD -p tcp --dport 80 -s hostA1 -d ip_xarxaB -j REJECT
iptables -A FORWARD -p tcp --sport 80 -d hostA1 -s ip_xarxa_B -m state --state RELATED,ESTABLISHED -j REJECT

iptables -A FORWARD -p tcp --dport 80 -s xarxa_A -d xarxa_B -j ACCEPT
iptables -A FORWARD -p tcp --sport 80 -d xarxa_A -d ip_xarxa_B -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A FORWARD -p tcp --dport 80 -s xarxa_A -d 0.0.0.0/0 -j REJECT
iptables -A FORWARD -p tcp --sport 80 -d xarxa_A -s 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j REJECT

#els hosts de la tota la xarxa A no poden fer ping
iptables -A FORWARD -p icmp --icmp-type 8 -s xarxa_A -d 0.0.0.0/0 -j REJECT
iptables -A FORWARD -p icmp --icmp-type 0 -d xarxa_A -s 0.0.0.0/0 -j REJECT

#portwarding 3001->A1:389
iptables -A FORWARD -p tcp --dport 389 -d A1 -s 0.0.0.0/0 -i fora -j ACCEPT
iptables -A FORWARD -p tcp --sport 389 -s A1 -d 0.0.0.0/0 -o fora -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A PREROUTING -p tcp --dprt 3001 -j DNAT --to A1:389
