#!/bin/bash

DEV=$(bluetoothctl devices | cat - <(echo power off)| dmenu -i -p 'choose device' -l 10 | cut -d\  -f2)

if [ "$DEV" = "off" ] ; then
	bluetoothctl power off
else
	bluetoothctl power on
	bluetoothctl connect $DEV
fi
