FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y htop build-essential rsync git python cmake
RUN ls -lha /opt
RUN mkdir /root/.ssh
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config
ADD download /root
WORKDIR /root
RUN chmod a+x download
RUN ./download

ADD compile /root
WORKDIR /root
RUN chmod a+x compile

# build vim
RUN apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    ruby-dev git

WORKDIR /tmp
RUN git clone https://github.com/vim/vim.git
WORKDIR /tmp/vim
RUN ./configure --with-features=huge \
		    --enable-multibyte \
		    --enable-rubyinterp \
		    --enable-pythoninterp \
		    --with-python-config-dir=/usr/lib/python2.7/config \
		    --enable-perlinterp \
		    --enable-luainterp \
		    --enable-gui=gtk2 --enable-cscope --prefix=/usr
RUN make VIMRUNTIMEDIR=/usr/share/vim/vim74
RUN make install
RUN vim --version

# javascript support ycm
RUN apt-get install -y nodejs npm libpython-dev build-essential cmake ctags
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
ADD compile compile
RUN ./compile

RUN mkdir -p /opt/build_prep
WORKDIR /root
RUN rm .vimrc && ln -s .vim/bundle/vim-my-settings/.vimrc
RUN tar cfz /opt/build_prep/marcvim.tar.gz .vim .vimrc .vim-mysettings
CMD cp /opt/build_prep/marcvim.tar.gz /opt/build
