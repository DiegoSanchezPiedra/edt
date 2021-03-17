#!/usr/bin/python

import os, sys
import cgitb; cgitb.enable()

write = sys.stdout.write

write('Content-Type: text/plain; charset=UTF-8\r\n')
write('\r\n')

for (k, v) in os.environ.items():
    write("%s = %s\n" % (k, v))
