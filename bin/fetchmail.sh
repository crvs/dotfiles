#!/bin/sh
#
# I lock my passwords using `email-lock` since gpg-agent is assumed to be
# running, signing a message with the key will make it accessible to
# offlineimap.
#

KEY_NAME=email-lock
FILE=$(mktemp)


dd iflag=fullblock if=/dev/random of=$FILE bs=128 count=20 2>/dev/null
gpg --local-user $KEY_NAME --sign $FILE
STATUS=$?
[[ $STATUS -eq 0 ]] && offlineimap 1>& /dev/null &


shred -u $FILE{,.gpg} 2> /dev/null || true
exit $STATUS
