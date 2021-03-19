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
#iptables -A OUTPUT -p tcp --dport 2013 -d 10.200.243.203 -j REJECT
#iptables -A OUTPUT -p tcp --dport 2013 -j ACCEPT

#permetre accedir al port 13 de qualsevol destí
#iptables -A OUTPUT -p tcp --dport 13 -d 0.0.0.0/0 -j ACCEPT

# Polítiques per defecte: 
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir el docker (no caldria ja que tenim posada la politica general a accept)
#iptables -A INPUT -s 172.18.0.1 -j ACCEPT
#iptables -A OUTPUT -d 172.18.0.1 -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 192.168.0.15 -j ACCEPT
iptables -A OUTPUT -d 192.168.0.15 -j ACCEPT

#=====================================================================
#denegar tot accés exterior al port 80 443 8080
#iptables -p tcp -A OUTPUT --dport 80 -j REJECT
#iptables -p tcp -A OUTPUT --dport 443 -j REJECT
#iptables -p tcp -A OUTPUT --dport 8080 -j REJECT

#denegar tota sortida del protocol tcp al port 13
#iptables -p tcp -A OUTPUT --dport 13 -j DROP

#accedir a tots el ports 13 de tot el mon excepte el del host que es diu host1(172.18.0.2)
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.2 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT

#prohibir a la xarxa 172.18.0.2/24 acces al port 13 pero permetre-ho al host2 i a la resta del mon
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.3 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.0/24 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT

#des del nostre ordinador no podem accedir al port 13 ni la ip del host2 ni la ip (iventada) i a la resta si
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.3 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.4 -j REJECT
#iptables -A OUTPUT -p tcp --dport 13 -j ACCEPT

#al host h1 i h2 denegat qualsevol acces
#iptables -A OUTPUT -d 172.18.0.3 -j REJECT
#iptables -A OUTPUT -d 172.18.0.2 -j REJECT
#iptables -A OUTPUT -d 0.0.0.0/0 -j ACCEPT

#xapar acces xarxes 172.18.0.0/24 i 172.19.0.0/24, la resta obert
#iptables -A OUTPUT -d 172.18.0.0/24 -j REJECT
#iptables -A OUTPUT -d 172.19.0.0/24 -j REJECT
#iptables -A OUTPUT -j ACCEPT

#prohibir accés al port 13 a tothom, permetre'l a la xarxa 18, denegar host1
iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.2 -j REJECT
iptables -A OUTPUT -p tcp --dport 13 -d 172.18.0.0/24 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 13 -j REJECT

#prohibir accés a la xarxa 2hisix excepte per ssh
iptables -A OUTPUT -p tcp --dport 22 -d 172.18.0.0/24 -j REJECT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
