FROM alpine:latest

RUN apk update && \
  apk add --no-cache bash vim openssh curl git tmux sudo 
RUN apk add --no-cache python3 py3-pip
RUN addgroup -S e && adduser -S e -G e -s /bin/bash -h /home/e && \
  echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chown -R e:e /home/e

USER e
RUN cd && git clone https://github.com/iofq/.dotfiles && \ 
  cd .dotfiles && \
  ./install -f && \
  ssh-keygen -f ~/.ssh/id_rsa -N "" >/dev/null

ENV args="-c tmux new-session -s e -d"
ENTRYPOINT exec bash $args
