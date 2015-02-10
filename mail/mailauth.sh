#!/bin/bash

if [ "$1" == "deauth" ];
then
    shred /home/crvs/crypt/gmail /home/crvs/crypt/ist /home/crvs/crypt/kth 1>&/dev/null || true
    rm /home/crvs/crypt/gmail /home/crvs/crypt/ist /home/crvs/crypt/kth 1>&/dev/null || true
else
    if [ -r /home/crvs/crypt/gmail ];
    then
        shred /home/crvs/crypt/gmail /home/crvs/crypt/ist /home/crvs/crypt/kth;
        rm    /home/crvs/crypt/gmail /home/crvs/crypt/ist /home/crvs/crypt/kth;
        echo "revoked authentication, press any key to continue...";
    else
        python2 /home/crvs/.dotfiles/mail/batchpass.py 1>&/dev/null;
        if [ $? -eq '0' ];
        then
            revoketime=$(date --date @$(( $(date +'%s') + 1800)) +'%y%m%d%H%M.%S')
            revokekeys="shred /home/crvs/crypt/gmail /home/crvs/crypt/ist /home/crvs/crypt/kth || true \
                        && rm /home/crvs/crypt/gmail /home/crvs/crypt/ist /home/crvs/crypt/kth"
            echo $revokekeys | at -t $revoketime 1>&/dev/null;
            echo "database unlocked, press any key to continue...";
        else
            echo "authentication failed, press any key to continue...";
        fi
    fi
    read -n 1
fi
