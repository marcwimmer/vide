FROM ubuntu:14.04

RUN apt-get update && apt-get install -y vim
RUN apt-get install -y ctags inotify-tools npm nodejs
RUN apt-get install -y git

RUN npm install -g jshint

CMD while true; do sleep 10; done;
