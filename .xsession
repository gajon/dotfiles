#!/bin/sh

# Make a .xinitrc symlink to this file if using `startx`
# And a .Xclients symlink to this file if using GDM.

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/usr/lib/X11/xinit/.Xresources
sysmodmap=/usr/lib/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
test -f $sysresources && xrdb -merge $sysresources
test -f $sysmodmap && xmodmap $sysmodmap
test -f $userresources && xrdb -merge $userresources
test -f $usermodmap && xmodmap $usermodmap

mpd &
xscreensaver -no-splash &

# This is a symlink to an image.
wmsetbg ~/.wallpaper

exec ion3
