#!/bin/sh
# ~/.xinitrc

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f $sysresources ]] && xrdb -merge $sysresources
[[ -f $sysmodmap ]] && xmodmap $sysmodmap
[[ -f "$userresources" ]] && xrdb -merge "$userresources"
[[ -f "$usermodmap" ]] && xmodmap "$usermodmap"

#userland
xset r rate 300 60
xrandr --output eDP-1 --mode 1920x1080
echo 80 > /sys/class/backlight/intel_backlight/brightness
sxhkd &
picom &
redshift -l 43:-89 -t 6100k:3000k &

#system-specific scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
if [ $TERM = linux ] || [ -e "/etc/systemd/system/graphical.target.wants/xlogin@$(whoami).service" ] ; then
  exec bspwm
fi
