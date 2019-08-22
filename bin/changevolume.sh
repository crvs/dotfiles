#!/bin/sh

INDICES=$(pacmd list-sinks | grep -e 'index:' | cut -d: -f2)

for i in $INDICES; do
	if [ "$1" = "mute" ]; then
		pactl set-sink-mute $i toggle
	elif [ "$1" = "up" ]; then
		pactl set-sink-mute $i false
		pactl set-sink-volume $i +5%
	elif [ "$1" = "down" ]; then
		pactl set-sink-mute $i false
		pactl set-sink-volume $i -5%
	fi
done

[ -f /tmp/barsh_id ] && kill -12 $( cat /tmp/barsh_id )
