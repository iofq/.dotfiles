FROM archlinux:latest
#TODO: env file for packages to install

#base
RUN pacman --noconfirm -Syu && \
  pacman --noconfirm -Syu vim zsh git htop wget curl sudo make \
  gcc tmux openssh exa

#development
RUN pacman --noconfirm -Syu nodejs npm python python-pip rust ansible

#networking
RUN pacman --noconfirm -Syu tcpdump nmap 

# User setup
RUN useradd -m e && \
  echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chsh -s /bin/zsh e && \
  chown -R e:e /home/e && \
  ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

# Ran as user e
USER e
RUN cd && git clone https://github.com/iofq/.dotfiles && cd .dotfiles && ./install && \
    ssh-keygen -f ~/.ssh/id_rsa -N "" >/dev/null

EXPOSE 22
ENV args="-c tmux"
ENTRYPOINT exec zsh $args
