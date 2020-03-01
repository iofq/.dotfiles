FROM archlinux:latest

#base
RUN pacman --noconfirm -Syu && \
  pacman --noconfirm -S vim zsh git htop wget curl sudo make \
  gcc tmux openssh exa

#development
RUN pacman --noconfirm -Syu nodejs npm python python-pip rust 

# User setup
RUN useradd -m e && \
  echo "e ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  chsh -s /bin/zsh e && \
  chown -R e:e /home/e && \
  ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

# Ran as user e
USER e
RUN cd && git clone https://github.com/iofq/.dotfiles && cd .dotfiles && ./install

EXPOSE 22
CMD ["zsh"] 
