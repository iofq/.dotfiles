#!/bin/sh
# ~/.xinitrc

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f "$userresources" ]] && xrdb -merge "$userresources"
[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

#userland
xrandr --output DP-1 --mode 1920x1080 --primary
walbg /home/pape base16-flat
redshift -l 43:-89 -t 6100k:3400k &
autorun
