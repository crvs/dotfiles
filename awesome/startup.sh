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

# add Super_R in lenovo keyboard
echo "keycode 107 = Super_R NoSymbol Super_R" | xmodmap -

# disable system beep
xset -b

# kill mouse while typing
# for dell xps 13
syndaemon -i 1 -K -d

# start audio server
(pgrep pulse > /dev/null)
if [[ ! $? = 0 ]]; then
    start-pulseaudio-x11 &
fi

# Set the background color
xsetroot -solid black &

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
    unclutter &
fi
