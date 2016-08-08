#!/bin/bash

# set background
feh --bg-scale /home/crvs/.xmonad/wallpaper.jpg &

# run redshift if it is not running
(pgrep redshift > /dev/null)
if [[ ! $? = 0 ]]; then
    LISBON="38:-9"
    STOCKHOLM="59:18"
    setsid redshift -l $STOCKHOLM &
fi

# set terminal preferences
xrdb $HOME/.Xresources &

# set cursor
xsetroot -cursor_name left_ptr &

# add Super_R in keyboards with two supers
echo "keycode 107 = Super_R NoSymbol Super_R" | xmodmap -

# disable system beep
xset -b

# kill mouse while typing
# for dell xps 13
syndaemon -i 2 -d

# start audio server
(pgrep pulse > /dev/null)
if [[ ! $? = 0 ]]; then
    start-pulseaudio-x11 &
fi

# Set the background color
xsetroot -solid black &

# run autolocker
(pgrep xautolock > /dev/null)
if [[ ! $? = 0 ]]; then
    setsid xautolock -time 5 -locker "dm-tool lock" &
fi

# allow compositing (run if not running)
(pgrep compton > /dev/null)
if [[ ! $? = 0 ]]; then
    compton -C &
fi

# run the network mananger applet
(pgrep nm-applet > /dev/null)
if [[ ! $? = 0 ]]; then
    setsid nm-applet &
fi

# make the mouse disappears
(pgrep unclutter > /dev/null)
if [[ ! $? = 0 ]]; then
    setsid unclutter -idle 0.5 &
fi
