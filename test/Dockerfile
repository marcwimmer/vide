FROM ubuntu:14.04
#FROM ubuntu:16.04
RUN apt update && apt install -y rsync
WORKDIR /root
RUN \
echo 'You are using:' >> .bashrc && \
echo 'cat /etc/lsb-release' >> .bashrc
CMD while true; do sleep 1; done
