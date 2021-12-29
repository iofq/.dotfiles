#
# ~/.bash_profile
#
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.bashrc ]] && . ~/.bashrc
XDG_DESKTOP_DIR="$HOME"
GPG_2FA="cjriddz@protonmail.com"
PATH=$PATH:/usr/local/go/bin

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
