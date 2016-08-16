FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y htop build-essential rsync git python cmake
RUN ls -lha /opt
RUN mkdir /root/.ssh
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config


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

ADD decompression_script /opt/decompression_script
ADD vimupdate /root/.vimupdate
ADD gitwatch.sh /root/gitwatch.sh
ADD download download
ADD compile compile
ADD package package
RUN chmod a+x compile package download
CMD /tmp/vim/package 
