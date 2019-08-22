#!/bin/bash

DEV_MENU=$(bluetoothctl devices | cut -d' ' -f2)
STT_MENU=$(for d in ${DEV_MENU}; do
		bluetoothctl info $d | grep Connected: | awk '{print $2;}'
	done )

SEL=$(bluetoothctl devices | \
	cut -d' ' -f 2- | \
	paste <( echo $STT_MENU | tr ' ' '\n' | sed -e 's/no/(off)/' -e 's/yes/(on)/' ) - | \
	cat - <(echo power off) | \
	cat <(echo "") - | \
	dmenu -i -p 'choose device' -l 10 )

if [ "$SEL" = "power off" ] ; then
	bluetoothctl power off
	notify-send "bluetooth off"
	return 0
elif [ "$SEL" = "" ] ; then
	return 0
else
	DEV=$( echo $SEL | cut -d' ' -f 2 )
	DEV_NAME=$( echo $SEL | cut -d' ' -f 3- )

	PWR_STATUS=$( bluetoothctl show | grep Powered: | awk '{ print $2; }' )

	[ "${PWR_STATUS}" = "no" ] && bluetoothctl power on && notify-send "bluetooth on"

	DEV_CONNECTED=$( bluetoothctl info ${DEV} | grep Connected: | awk '{print $2;}' )

	if [ ${DEV_CONNECTED} = "yes" ]; then
		bluetoothctl disconnect ${DEV} || notify-send "failed to connect to ${DEV_NAME}"
		notify-send "disconnected from ${DEV_NAME}"
	else
		bluetoothctl connect ${DEV}
		notify-send "connected to ${DEV_NAME}"
	fi
	return 0
fi
