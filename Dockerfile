FROM alpine:latest

#base
RUN apk update && \
  apk add --no-cache bash vim openssh curl git tmux sudo 

#dev
RUN apk add --no-cache ansible python3 

#net
RUN apk add --no-cache nmap 

#kubernetes
#RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
 # chmod +x ./kubectl && \
  #mv ./kubectl /usr/local/bin/kubectl

# User setup
RUN addgroup -S e && adduser -S e -G e -s /bin/bash -h /home/e && \
  echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chown -R e:e /home/e

# Ran as user e
USER e
RUN cd && git clone https://github.com/iofq/.dotfiles && cd .dotfiles && ./install && \
    ssh-keygen -f ~/.ssh/id_rsa -N "" >/dev/null

EXPOSE 22
ENV args="-c tmux"
ENTRYPOINT exec bash $args
