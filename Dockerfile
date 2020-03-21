FROM archlinux:latest
#TODO: env file for packages to install

#base
RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -Sy vim zsh git htop wget curl sudo make \
  gcc tmux openssh exa

#development
RUN pacman --noconfirm -Sy nodejs npm python python-pip rust ansible
#kubernetes
RUN  curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl && \

#networking
RUN pacman --noconfirm -Sy tcpdump nmap 

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
#build yay
RUN git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
#doctl
RUN yay --noconfirm -Sy doctl-bin

EXPOSE 22
ENV args="-c tmux"
ENTRYPOINT exec zsh $args
