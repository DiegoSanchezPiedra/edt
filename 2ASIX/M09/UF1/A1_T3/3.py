#!/usr/bin/python

import os, sys
import cgitb; cgitb.enable()

write = sys.stdout.write

write('Content-Type: text/plain; charset=UTF-8\r\n')
write('\r\n')

user_agent = os.environ.get("HTTP_USER_AGENT", "A bad client!")
write("User-Agent:" + user_agent + '\n')

if "HTTP_REFERER" in os.environ:
    http_referer  = os.environ["HTTP_REFERER" ]
    write("Referer: " + http_referer + '\n')

if "HTTP_ACCEPT_LANGUAGE" in os.environ:
    write("Accept-Language: " + os.environ["HTTP_ACCEPT_LANGUAGE"] + '\n')
