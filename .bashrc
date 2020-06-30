# ~/.bashrc

[[ $- != *i* ]] && return
PS1='\[\033[01;35m\][\u\[\033[01;36m\] \W\[\033[01;35m\]]\$\[\033[00m\] '
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
bind "set vi-cmd-mode-string \033[01;31mN"

# tab completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
complete -cf sudo
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind '"\t":menu-complete'

# aliases
alias la='ls -lah'
alias ..='cd ..'
alias :q="exit"
alias ssh="export TERM=vt100 && ssh"      #compatibility
alias gitu='git add . && git commit && git push'
which rsync 2>&1 >/dev/null && alias cp="rsync -avh --progress"

# cd && ls
function cd {
  cmd="ls"
  which exa>/dev/null 2>&1 && cmd="exa"
  builtin cd "$@" && $cmd
}

which exa 2>&1 >/dev/null && alias ls='exa'

which 'fzf' 2>&1 >/dev/null && \
  source /usr/share/fzf/key-bindings.bash && \
  source /usr/share/fzf/completion.bash
