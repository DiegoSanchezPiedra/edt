#!/usr/bin/python

import urllib, os
import cgitb ; cgitb.enable()

def parse(s):
    """Parse the url-encoded string s returning a dictionary.
    Caveat: does not support duplicated keys, etc.
    """
    if s == "": 
        return {}
    pairs = s.split("&")
    
    pairs = [(k, urllib.parse.unquote_plus(v))
              for (k, v) in [s.split("=", 1) for s in pairs]]
    
    return pairs

form = parse(os.environ["QUERY_STRING"])
print("Content-Type: text/plain\n\n")
print (form)