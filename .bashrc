# ~/.bashrc

[[ $- != *i* ]] && return
export PS1="\[\033[38;5;5m\][\u@\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;5m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;2m\]\\$\[$(tput sgr0)\] "
export PATH=~/.bin:$PATH
xhost +local:root > /dev/null 2>&1

shopt -s cmdhist
shopt -s globstar 2> /dev/null
shopt -s expand_aliases 2> /dev/null
shopt -s dirspell 2> /dev/null
shopt -s cdspell 2> /dev/null
shopt -s histappend 2> /dev/null
PROMPT_COMMAND='history -a'
HISTSIZE=5000
HISTFILESIZE=50000

# vi mode
set -o vi
bind "set show-mode-in-prompt on"
bind "set vi-ins-mode-string "
bind "set vi-cmd-mode-string \033[01;31mN "

# tab completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind '"\t":menu-complete'

# aliases
alias la='/bin/ls -lah'
alias ..='cd ..'
alias :q="exit"
alias gitu='git add . && git commit && git push'
which rsync 2>&1 >/dev/null && alias cp="rsync -avh --progress"

# cd && ls
function cd {
  cmd="ls"
  which exa>/dev/null 2>&1 && cmd="exa"
  builtin cd "$@" && $cmd
}

#change $TERM while we ssh for compatibility
function ssh_compat {
  OLDTERM=$TERM
  export TERM=vt100
  ssh $@ && export TERM=$OLDTERM && unset OLDTERM
}
alias ssh="ssh_compat"

which exa 2>&1 >/dev/null && alias ls='exa'

which 'fzf' 2>&1 >/dev/null && \
  source /usr/share/fzf/key-bindings.bash && \
  source /usr/share/fzf/completion.bash
