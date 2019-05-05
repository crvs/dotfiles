#!/bin/bash

# dependencies:
# - jq -- mine json files
# - pinfetcher.sh -- script to call pinentry
# - mpw -- masterpassword cli


USERS=$(ls ~/.mpw.d | awk -F. '{print $1;}')
TEMP=$(mktemp)
for u in $USERS; do
    cat ~/.mpw.d/$u.mpsites.json | jq '.sites | keys ' | awk -v u="$u" -F\" '/\w/ {print $2,u;}' | column -t > $TEMP
done

declare $(cat $TEMP | dmenu -l 10 | awk '{print "PSITE="$1," PUSER="$2;}')
export MPW_ASKPASS=~/.dotfiles/bin/pinfetcher.sh
for i in {1..3}; do
    mpw -u $PUSER $PSITE 2> $TEMP | xclip
    grep Incorrect $TEMP
    INCORRECT=$?
    if [ ! $INCORRECT ]; then
        break
    fi
done
unset MPW_ASKPASS
rm $TEMP

if [ ! $INCORRECT ]; then
    notify-send "failed to copy password"
    exit 1
else
    notify-send "copied password to $PSITE ($PUSER)"
    sleep 30
    echo "" | xclip
fi
