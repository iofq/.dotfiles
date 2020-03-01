#!/bin/bash
#install zsh plugins 
mkdir -p ~/.zsh/plugins && \
cd ~/.zsh/plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-autosuggestions
