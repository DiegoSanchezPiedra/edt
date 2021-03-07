#!/usr/bin/python

import os
import sys

def get_encoding():
    try:
        lang = os.environ['LANG']
        encoding = lang[lang.index('.') + 1 :]
    except:
        encoding = 'UTF-8'
    return encoding
def encode(cadena=""):
    write = sys.stdout.write
    environ = os.environ

    write("Content-Type: text/plain; charset=%s\r\n" % (get_encoding()))
    write("\r\n")

    res=""
    for i in range(len(cadena)):
        if cadena[i] == '+':
            res += ' '
        else:
            res += cadena[i]
    print(res)

if __name__ == '__main__':
    encode("hola+que+tal")