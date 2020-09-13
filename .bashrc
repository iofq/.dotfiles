# ~/.bashrc

[[ $- != *i* ]] && return
export PS1="\[\033[38;5;5m\][\u@\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;5m\]]\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;2m\]\\$\[$(tput sgr0)\] "
export PATH=~/.bin:$PATH
export EDITOR=vim
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
  source /usr/share/doc/fzf/examples/completion.bash

__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}
__fzf_history__() {
  local output
  output=$(
    builtin fc -lnr -2147483648 |
      last_hist=$(HISTTIMEFORMAT='' builtin history 1) perl -n -l0 -e 'BEGIN { getc; $/ = "\n\t"; $HISTCMD = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCMD - $. . "\t$_" if !$seen{$_}++' |
      FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m --read0" $(__fzfcmd) --query "$READLINE_LINE"
  ) || return
  READLINE_LINE=${output#*$'\t'}
  if [ -z "$READLINE_POINT" ]; then
    echo "$READLINE_LINE"
  else
    READLINE_POINT=0x7fffffff
  fi
}
# CTRL-R - Paste the selected command from history into the command line
  bind -m emacs-standard -x '"\C-r": __fzf_history__'
  bind -m vi-command -x '"\C-r": __fzf_history__'
  bind -m vi-insert -x '"\C-r": __fzf_history__'
