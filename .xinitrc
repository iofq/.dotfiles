#!/bin/sh
# ~/.xinitrc

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
setxkbmap -layout us -option '' -option ctrl:nocaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

#userland
autorandr --load lap
xbacklight -set 80
sxhkd &
picom &
bspwmrice.sh &
redshift -l 43:-89 -t 6500k:3700k &

#system-specific scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
if [ $TERM = linux ] || [ -e "/etc/systemd/system/graphical.target.wants/xlogin@$(whoami).service" ] ; then
session=${1:-bspwm}

case $session in
	awesome 		  ) exec dbus-launch --sh-syntax --exit-with-session awesome;;
	gnome 			  ) exec dbus-launch --sh-syntax --exit-with-session gnome-session;;
	bspwm 			  ) exec dbus-launch --sh-syntax --exit-with-session bspwm-session;;
  i3|i3wm           ) exec dbus-launch --sh-syntax --exit-with-session i3;;
  kde               ) exec dbus-launch --sh-syntax --exit-with-session startkde;;
  budgie            ) exec dbus-launch --sh-syntax --exit-with-session budgie-desktop;;
  openbox           ) exec dbus-launch --sh-syntax --exit-with-session openbox-session;;
  xfce|xfce4        ) exec dbus-launch --sh-syntax --exit-with-session startxfce4;;
  # No known session, try to run it as command
  *                 ) exec dbus-launch --sh-syntax --exit-with-session $1;;
esac
fi
