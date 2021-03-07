#!/usr/bin/python

import os
import sys
import urllib.parse
def get_encoding():
    try:
        lang = os.environ['LANG']
        encoding = lang[lang.index('.') + 1 :]
    except:
        encoding = 'UTF-8'
    return encoding

def decode(cadena=""):
    write = sys.stdout.write
    environ = os.environ

    write("Content-Type: text/plain; charset=%s\r\n" % (get_encoding()))
    write("\r\n")
    
    cadena = urllib.parse.unquote(cadena)
    
    res=""
    for i in range(len(cadena)):
        if cadena[i] == '+':
            res += ' '
        else:
            res += cadena[i]
    write(res)

if __name__ == '__main__':
    decode("hola+que+tal")