#
# ~/.bash_profile
#
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.bashrc ]] && . ~/.bashrc

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
