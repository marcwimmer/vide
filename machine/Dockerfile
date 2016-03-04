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

WORKDIR /root

# build vim
RUN apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libatk1.0-dev libbonoboui2-dev \
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
		    --enable-cscope --prefix=/usr
RUN make VIMRUNTIMEDIR=/usr/share/vim/vim74
RUN make install
RUN vim --version

# javascript support ycm
RUN apt-get install -y nodejs npm libpython-dev build-essential cmake ctags
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

ADD compile compile
RUN chmod a+x compile
RUN ./compile

# build tar 
RUN mkdir -p /opt/build_prep
WORKDIR /root
ADD vimupdate .vimupdate
RUN rm .vimrc && ln -s .vim/bundle/vim-my-settings/.vimrc 
RUN tar cf /opt/files.tar .vim-my-settings .vimupdate
RUN tar --append --file /opt/files.tar -C /usr/bin vim

#tar to gzipped tar
RUN gzip /opt/files.tar

ADD decompression_script /opt/decompress
WORKDIR /opt
RUN cat decompress files.tar.gz > marcvim_installer.sh
RUN chmod a+x marcvim_installer.sh
RUN ./marcvim_installer.sh
CMD cp /opt/marcvim_installer.sh /opt/marcvim; cp files.tar.gz /opt/marcvim; ls -lha /root
