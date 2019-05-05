#!/bin/sh
#
# unlock a gpg key
# usage: unlock.sh <gpg-key>
#

ACCOUNT=$1 # account to unlock
FILE=$(mktemp)
LOCK_FILE=/tmp/$ACCOUNT-locked
touch $LOCK_FILE
dd iflag=fullblock if=/dev/random of=$FILE bs=128 count=20 2>/dev/null
gpg --local-user $ACCOUNT --sign $FILE
STATUS=$?
[[ $STATUS ]] && rm $LOCK_FILE
shred -u $FILE 1>/dev/null || true
shred -u $FILE.gpg 1>/dev/null || true
exit $STATUS
