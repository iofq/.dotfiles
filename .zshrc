export EDITOR=/usr/bin/vim
setopt correct
setopt nobeep
setopt histignorealldups
setopt autopushd

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
HISTFILE=~/.zsh/.zhistory
HISTSIZE=1000
SAVEHIST=10000

autoload -U compinit colors
compinit -d
colors
PROMPT="%b%{$fg[magenta]%}[%(4~|%-1~/.../%2~|%~)]%u%b%{$reset_color%}$ "

# auto ls
funtion chpwd() {
    emulate -L zsh
    if which exa 2>&1 >/dev/null; then
        exa
    else
        ls
    fi
}
# vi mode
bindkey -v
stty -ixon
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/ }"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

source ~/.bash_aliases
which fzf > /dev/null && source /usr/share/fzf/completion.zsh
which fzf > /dev/null && source /usr/share/fzf/key-bindings.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
