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
RUN apt-get install -y libncurses5-dev python-dev ruby-dev nodejs npm libpython-dev build-essential cmake ctags

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
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

ADD decompression_script /opt/decompress
ADD vimupdate /root/.vimupdate
ADD compile compile
ADD package package
RUN chmod a+x compile
RUN chmod a+x package
CMD /tmp/vim/package 
