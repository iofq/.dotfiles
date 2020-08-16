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
xsetroot -cursor_name left_ptr &
xcape -e "Super_L=Escape"
xset r rate 300 60
xrandr --output eDP-1 --mode 1920x1080
walbg /home/pape base16-flat

#system-specific scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
if [ $TERM = linux ] || [ -e "/etc/systemd/system/graphical.target.wants/xlogin@$(whoami).service" ] ; then
exec spectrwm
fi
