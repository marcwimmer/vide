FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y htop build-essential rsync git python2.7
RUN ls -lha /opt
RUN mkdir /root/.ssh
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config
ADD marcvim /root
WORKDIR /root
RUN chmod a+x marcvim
RUN ./marcvim
CMD ./compile.sh
