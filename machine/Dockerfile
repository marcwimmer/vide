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

RUN apt-get install -y iputils-ping
# javascript support ycm
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
RUN apt-get install -y automake pkg-config liblzma-dev libpcre3-dev
ADD build-silver-surfer.sh build-silver-surfer.sh
RUN rm -Rf /opt/clone_ag/ || true
RUN rm -Rf /opt/clone/ || true
RUN chmod a+x ./build-silver-surfer.sh && ./build-silver-surfer.sh

ADD download download
RUN chmod a+x download && ./download

ADD decompression_script /opt/decompression_script
ADD vimupdate /root/.vimupdate
ADD gitwatch.sh /root/gitwatch.sh
ADD compile compile
ADD package package
RUN chmod a+x compile package

VOLUME /opt/clone
VOLUME /opt/clone_vimmysettings
VOLUME /opt/clone_vundle
VOLUME /opt/clone_UltiSnips

CMD /tmp/vim/package 
