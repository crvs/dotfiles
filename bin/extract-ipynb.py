#!/usr/sbin/env python3

import sys
import re
import os
import base64

filename = sys.argv[1]
m = re.search('\.[^\.]+$',filename)
if m is not None:
    basename = filename[:m.start()]
else:
    basename = filename

os.mkdir(basename)
outname = basename + '/output_'

i = 0
with open( filename , 'r')  as f:
    for l in f.readlines():
        if re.search('image',l):
            s = l.split()[1][1:-4]
            I = base64.standard_b64decode(s)
            pname = outname + str(i) + '.png'
            with open( pname ,'wb') as g:
                print(pname)
                g.write(I)
                i += 1
