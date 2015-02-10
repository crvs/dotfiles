#!/bin/bash

# needs to be able to recognize if its jpg or png...
# note that it also works with png since linux doesn't use the extension name for anything...

# backup old wallpaper
mv $HOME/.xmonad/wallpaper.jpg \
   $HOME/.xmonad/wallpapers.old/"wall"`date +"%Y%m%d"`-`md5sum $HOME/.xmonad/wallpaper.jpg | cut -c1-6`".jpg"
# copy new wallpaper to where it should be
mv $1 $HOME/.xmonad/wallpaper.jpg
# start using the new background
feh --bg-fill $HOME/.xmonad/wallpaper.jpg
