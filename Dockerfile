FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    rsync \
    git \
    cmake \
    libncurses5-dev \
    ruby-dev \
    build-essential \
    cmake \
    ctags \
    apt \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip \
    wget \
    pkg-config \
    liblzma-dev \
    libpcre3-dev \
    silversearcher-ag \
    curl \
    golang-go \
    libxml2-utils \
    gosu \
    gettext \
    coderay \
    python3-pip \ 
    python3-dev \ 
    gperf \
    luajit \
    luarocks \
    libuv1-dev \
    libluajit-5.1-dev \
    libunibilium-dev \
    libmsgpack-dev \
    libtermkey-dev \
    libvterm-dev \
    software-properties-common \
    locales

RUN locale-gen "en_US.UTF-8"
ENV LC_CTYPE="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"

RUN pip3 install unidecode pudb flake8 pynvim pathlib
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt update & apt install -y nodejs
RUN npm install -g jshint neovim

# ssh setup
RUN mkdir /root/.ssh
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config

# user vide
RUN useradd -ms /bin/bash vide

# setup nodejs
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

# clone and compile fzf
USER vide
WORKDIR /home/vide
RUN git clone --depth 1 https://github.com/junegunn/fzf fzf
WORKDIR /home/vide/fzf
RUN ./install
USER root
RUN cp bin/fzf /usr/local/bin


# clone and compile neovim
WORKDIR /usr/src
RUN git clone --depth 1 https://github.com/neovim/neovim
WORKDIR /usr/src/neovim
RUN make -j4 CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make -j4 install
RUN cp /usr/local/bin/nvim /usr/bin/vim


# install plugin loader for the bundles, so that PlugInstall works
USER vide
RUN mkdir -p ~/.vim/bundle
RUN chown vide:vide /home/vide/.vim/bundle -R
WORKDIR /home/vide/.vim/bundle
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# download minimal plugins
USER vide
#RUN git clone --depth 1 https://github.com/VundleVim/Vundle.vim Vundle.vim 
ADD vim-my-settings vim-my-settings
RUN mkdir -p /home/vide/.config/nvim
ADD files/vimrc /home/vide/.config/nvim/init.vim
RUN echo '1'
RUN nvim +PlugInstall +qall

RUN cd YouCompleteMe && \
git submodule update --init --recursive && \
/usr/bin/python3 install.py # --tern-completer


# final steps, setup env and prepare start.sh
USER root
ADD files/start.sh /start.sh
RUN chmod a+x /start.sh

WORKDIR /home/vide
USER root
ADD files/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod a+x /usr/bin/entrypoint.sh

RUN  ln -s /usr/bin/ag /home/vide/.vim/ag

ENTRYPOINT /usr/bin/entrypoint.sh "$@"
RUN apt install -y python3-lxml
RUN apt install -y python python-pip python-lxml
RUN pip install unidecode pudb flake8 neovim
RUN pip install python-vim
CMD []
