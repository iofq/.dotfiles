#!/bin/bash
alias cp="rsync -avh --progress"
alias cd="cd && ls"
alias la='ls -lah'
alias cl="clear"
alias update="yay -Syyu"
alias more="less"
alias free="free -m"
alias cdd='cd ..'
alias :q="exit"
alias ssh="export TERM=vt100 && ssh"      #compatibility
alias df='df -h'                                               # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias rice="cd /home/code"
alias dev="cd /mnt/nfs/personal/dev"
if which exa 2>&1 >/dev/null; then
    alias ls='exa'
fi
