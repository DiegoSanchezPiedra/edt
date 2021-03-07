#!/usr/bin/python

import urllib, os
from decode import decode
import cgitb ; cgitb.enable()

def parse(s):
    """Parse the url-encoded string s returning a dictionary.
    Caveat: does not support duplicated keys, etc.
    """
    if s == "": 
        return {}
    pairs = s.split("&")
    
    for el in pairs:
        if el == '':
            raise ValueError('Bad query string')
        elif '=' not in el:
            raise ValueError('Bad query string')

    #pairs = [(k, urllib.parse.unquote_plus(v))
    pairs = [(k, decode(v))
              for (k, v) in [s.split("=", 1) for s in pairs]]
    
    return pairs

form = parse('N=4&M=3&OP=suma&OP=resta&OP=suma')
#form = parse('N=4&&OP=suma&OP=resta&OP=suma')
#form = parse('N4&M=3&OP=suma&OP=resta&OP=suma')
print("Content-Type: text/plain\n\n")
print (form)