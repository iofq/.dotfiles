FROM golang:alpine

RUN apk update && \
  apk add --no-cache \
    bash \
    curl \
    git \
    ncurses \
    neovim \
    openssh \
    sudo \
    tmux

RUN addgroup -S e && adduser -S e -G e -s /bin/bash -h /home/e && \
  echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chown -R e:e /home/e

USER e
RUN cd && git clone https://github.com/iofq/.dotfiles && \ 
  cd .dotfiles && \
  ./install -f && \
  ssh-keygen -f ~/.ssh/id_rsa -N "" >/dev/null

ENTRYPOINT ["tmux"]
