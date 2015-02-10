#!/bin/sh

CURRLIGHT=`xbacklight`

if [ $CURRLIGHT = '0.000000' ]; then
    NEWLIGHT=`head -n 1 /var/run/user/1000/backlightStatus`
    xbacklight -set $NEWLIGHT
else
    xbacklight > /var/run/user/$UID/backlightStatus
    xbacklight -set 0
fi
