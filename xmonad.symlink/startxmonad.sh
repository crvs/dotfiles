#!/bin/sh
#
# ~/.xmonad/startxmonad
#


## change the default erase symbol
stty erase \^\? &

## set terminal preferences
xrdb $HOME/.Xresources &

## set cursor
xsetroot -cursor_name left_ptr &

## disable system beep
xset -b
amixer -c 0 set 'Beep' 0% mute 2> /dev/null

# turn off touchpad
synclient TouchpadOff=1 &

# make sure the keyboard is set properly so that keepassx autotype works
setxkbmap us,us -variant dvorak,dvorak-intl caps:escape,grp:sclk_toggl,grp_led:scroll

# enable scrolling (vertical and horizontal) with trackpoint, fix found at thinkwiki 2014/02/02
xinput --set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1 &
xinput --set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2 &
xinput --set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200 &
xinput --set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5 &

# start audio server
(pgrep pulse > /dev/null)
if [[ ! $? = 0 ]]; then
    start-pulseaudio-x11 &
fi

## enable numlock 
numlockx &

# Set the background color
xsetroot -solid black &

(pgrep xscreensaver > /dev/null)
if [[ ! $? = 0 ]]; then
    xscreensaver -no-splash &
fi

# allow compositing (run if not running)
(pgrep compton > /dev/null)
if [[ ! $? = 0 ]]; then
    compton -C &
fi

# make the mouse disappears
(pgrep unclutter > /dev/null)
if [[ ! $? = 0 ]]; then
    unclutter &
fi

exec xmonad
