#!/usr/bin/python

#QUERY_STRING='Nom=Diego&Cognoms=Sanchez%20Piedra' python3 2.py 

import os, sys
import cgitb; cgitb.enable()

write = sys.stdout.write

write('Content-Type: text/plain; charset=UTF-8\r\n')
write('\r\n')

import urllib

camps = os.environ['QUERY_STRING'].split("&")
#separa los valores indicando que el separador es & por lo tanto queda: 
# ['Nom=Diego', 'Cognoms=Sanchez%20Piedra']

for i in range(len(camps)):
    camps[i] = camps[i].split("=", 1)
#separa (en una lista de lista) separando nom y diego en una lista y luego separando cognoms y sanchez%20piedra en otra lista, todo dentro de otra lista

for i in range(len(camps)):
    camps[i] = (camps[i][0], urllib.parse.unquote_plus(camps[i][1]))
#transforma sanchez%20piedra a sanchez piedra, es decir traduce los caracteres especiales con la funcion urllib.parse.unquote_plus

for (k, v) in camps:
    write("%s = %s\n" % (k, v))
#muestra en formato nom=Diego y Cognmos=Sanchez Piedra
