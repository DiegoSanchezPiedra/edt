#!/usr/bin/python

import os
import sys
import urllib.parse
import random
import cgitb; cgitb.enable()
def get_encoding():
    try:
        lang = os.environ['LANG']
        encoding = lang[lang.index('.') + 1 :]
    except:
        encoding = 'UTF-8'
    return encoding

def encode():
    write = sys.stdout.write

    write("Content-Type: text/plain; charset=%s\r\n" % (get_encoding()))
    write("\r\n")
    print(random.randint(1,1000))
    
if __name__ == '__main__':
    encode()