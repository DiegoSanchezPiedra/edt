#!/usr/bin/python
#diego sanchez piedra
#s='N=4&M=3&OP=suma&OP=resta'
import urllib, os
import cgitb 

def parse_rep(s):
    pairs = s.split('&')

    lista = []

    for el in pairs:
        lista.append(el.split('='))

    keys = []
    valores = []

    for el in range(len(lista)):
        keys.append(lista[el][0])
        valores.append([lista[el][1]])

    res = []

    for (k,v) in zip(keys,valores):
        v = [urllib.parse.unquote_plus(v[0])]
        res.append((k,v))

    res_dict = dict(res)

    for key in res:
        if key[1][0] not in res_dict[key[0]]:
            res_dict[key[0]].append(key[1][0])

    return(res_dict)

if __name__=='__main__':
    form = parse_rep(os.environ["QUERY_STRING"])
    #form = parse_rep('N=4&M=3&OP=suma&OP=resta')
    print("Content-Type: text/plain\n\n")
    print(form)