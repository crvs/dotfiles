#!/bin/bash

if [ -r /home/crvs/crypt/gmail ];
then
    if [ "$1" == "inbox" ];
    then
        setsid offlineimap -a gmail -f INBOX -1 1>&/dev/null &
        setsid offlineimap -a ist   -f INBOX -1 1>&/dev/null &
        setsid offlineimap -a kth   -f INBOX -1 1>&/dev/null &
        echo "retrieveng emails from INBOX, press any key to continue..."
    else
        setsid offlineimap -a gmail -1 1>&/dev/null &
        setsid offlineimap -a ist   -1 1>&/dev/null &
        setsid offlineimap -a kth   -1 1>&/dev/null &
        echo "retrieveng ALL emails, press any key to continue..."
    fi
else
    echo "NOT authenticated, press any key to continue..."
fi
read -n 1
