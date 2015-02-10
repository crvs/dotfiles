#!/usr/sbin/env python2

from keepass import kpdb
import getpass, os

# TODO: check file permissions

db = kpdb.Database("/home/crvs/crypt/keedb.kdb",getpass.getpass("Password for database: "))
for entry in db.entries:
    if entry.title in ["gmail","ist","kth"]:
        open("/home/crvs/crypt/"+entry.title,"w").write(entry.password)
