# Nethost
## @ edt ASIX M11-SAD Curs 2018-2019

Podeu trobar les imatges docker al Dockehub de [edtasixm11](https://hub.docker.com/u/edtasixm11/)

Podeu trobar la documentació del mòdul a [ASIX-M11](https://sites.google.com/site/asixm11edt/)

ASIX M06-ASO Escola del treball de barcelona

Repositori per a generar hosts amb serveis de xarxaserveis 

**edtasixm11/net18:nethost** Host amb tot de serveis de xarxa actius, i rèpliques per a
  fer tests de connectivitat, xinetd, tcpwrappers, túnels ssh i iptables.

**compose** directori amb exemples de docker-compose per a fer desplegaments combinant
  vàris containers, en especial el portainer i el visualizer.


#### Execució

Sense mapejar els ports
```
docker netweork create mynet
docker run --rm --name nethost.edt.org -h nethost.edt.org --net 2hisix -d isx2031424/net20:nethost
```

Amb ports mapejats
```
docker netweork create mynet
docker run --rm --name nethost.edt.org -h nethost.edt.org --net 2hisix -p 7:7 -p 13:13 -p 80:80 -d isx2031424/net20:nethost
```

