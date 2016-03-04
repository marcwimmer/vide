FROM ubuntu:14.04

USER root
RUN apt-get update
RUN apt-get install -y vim git rsync
RUN apt-get install -y python2.7 python2.7-dev libpython2.7-dev libc6-dev

# javascript support ycm
RUN apt-get install -y nodejs npm 
RUN apt-get install -y build-essential cmake
RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

RUN echo "deb [trusted=yes] http://deb.itewimmer.de/ ./" > /etc/apt/sources.list.d/deb.itewimmer.de.8.list
RUN apt-get update
RUN apt-get install -y marcvim

RUN marcvim
RUN rsync -arL /root/.vim/ /opt/vimenv/
RUN chmod a+rw /opt/vimenv -R
RUN find /opt/vimenv -type d -exec chmod a+x {} \;

VOLUME /opt/vimenv

CMD echo done; ls -lha /opt/vimenv/
