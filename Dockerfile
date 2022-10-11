FROM docker.io/golang:bullseye

ENV TERM=xterm-256color
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && \
    apt -y install \
    bash-completion \
    build-essential \
    fzf \
    gopls \
    jq \
    sudo \
    tmux \
    yamllint

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

# Run PackerInstall & TSUpdate
RUN nvim --headless -c 'autocmd User PackerComplete quitall'
RUN nvim --headless -c ':TSInstallSync all | qall'

# archive home directory for portability
# docker cp <id>:/home/e/dots.tgz .
RUN tar -cvzhf /tmp/dots.tgz ~/ && mv /tmp/dots.tgz ~/dots.tgz

ENTRYPOINT ["tmux"]
