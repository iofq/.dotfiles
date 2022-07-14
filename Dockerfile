FROM docker.io/golang:1.18-bullseye

RUN apt update && \
    apt -y install \
    bash \
    bash-completion \
    curl \
    git \
    openssh-client \
    sudo \
    tmux \
    fzf
# Install nightly neovim
RUN curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb && dpkg -i nvim-linux64.deb

RUN groupadd -g 1000 e && useradd -u 1000 -g e -s /bin/bash -m e && \
  echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chown -R e:e /home/e

USER e
WORKDIR /home/e

RUN cd && git clone https://github.com/iofq/.dotfiles && \ 
  cd .dotfiles && \
  ./install -f && \
  ssh-keygen -f ~/.ssh/id_rsa -N "" >/dev/null

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Run PackerInstall & TSUpdate
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

ENTRYPOINT ["tmux"]
