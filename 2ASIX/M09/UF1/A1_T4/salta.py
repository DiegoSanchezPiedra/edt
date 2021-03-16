#!/usr/bin/python
'''
Fes un script de nom salta que en ser visitat redirigeixi a una URL triada a l’atzar d’una llista 
(has de redirigir amb la capçalera escrita per l’script Location: URL). 
Quin tipus de resposta de redirecció ha fet el servidor?
'''
import sys
import cgitb; cgitb.enable()
import random

def red():

    write = sys.stdout.write
    links = ['https://www.google.com/','https://www.twitch.tv/','https://twitter.com/']

    reurl = links[random.randint(0,2)]

    write ("Content-Type: text/html\n\n")
    write('<html>')
    write ('    <head>')
    write('<meta http-equiv="refresh" content="0;url='+str(reurl)+'" />')
    write ('    </head>')
    write('</html>')
if __name__=='__main__':
    red()