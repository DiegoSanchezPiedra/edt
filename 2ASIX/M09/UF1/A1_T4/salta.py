#!/usr/bin/python
'''
Fes un script de nom salta que en ser visitat redirigeixi a una URL triada a l’atzar d’una llista 
(has de redirigir amb la capçalera escrita per l’script Location: URL). 
Quin tipus de resposta de redirecció ha fet el servidor?
'''
import sys
import cgitb; cgitb.enable()
import random
from flask import Flask
'''
def red():

    write = sys.stdout.write
    links = ['https://www.google.com/','https://www.twitch.tv/','https://twitter.com/']

    url = links[random.randint(0,2)]

    write ("Content-Type: text/plain\n\n")
    
    return flask.redirect(url,code=302)
if __name__=='__main__':
    red()
'''

app = flask.Flask(__name__)

@app.route("/")
def starting():
    return flask.redirect("https://www.twitch.tv/")

app.run()