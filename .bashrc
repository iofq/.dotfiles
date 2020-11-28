# ~/.bashrc

[[ $- != *i* ]] && return
function prompt_command {
  GIT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null )
  [[ $GIT_BRANCH != '' ]] && \
  PS1="\[\033[38;5;5m\][\u@\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;5m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;3m\]($GIT_BRANCH)\[\033[38;5;2m\]\$\[$(tput sgr0)\] " || \
  PS1="\[\033[38;5;5m\][\u@\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;5m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;3m\]\[\033[38;5;2m\]\$\[$(tput sgr0)\] "
}
PROMPT_COMMAND='prompt_command;history -a'
export PATH=~/.bin:$PATH
export EDITOR=vim
xhost +local:root > /dev/null 2>&1

shopt -s cmdhist
shopt -s globstar 2> /dev/null
shopt -s dirspell 2> /dev/null
shopt -s cdspell 2> /dev/null
shopt -s histappend 2> /dev/null
HISTSIZE=1000
HISTFILESIZE=9999

# tab completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"
bind '"\t":menu-complete'
bind '"\ev":edit-and-execute-command' #alt-v edit in $EDITOR

# aliases
alias la='/bin/ls -lah --color=auto'
alias :q="exit"
alias gitu='git add . && git commit && git push'
alias aur="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print\$2}\")' | xargs -ro yay -S"
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
  ssh $@; export TERM=$OLDTERM; unset OLDTERM
}
alias ssh="ssh_compat"

which exa 2>&1 > /dev/null && alias ls='exa'
if [[ $(which 'fzf' 2>&1) ]]; then
  [ -r /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
  [ -r /usr/share/doc/fzf/examples/key-bindings.bash ] && source /usr/share/doc/fzf/examples/key-bindings.bash
  [ -r /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
  [ -r /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
fi
