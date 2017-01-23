FROM ubuntu:16.04
RUN apt-get update && apt-get install -y curl
RUN curl -o /tmp/vim http://vim.itewimmer.de/marcvim_installer_ubuntu-16.04.sh
RUN bash/tmp/vim
CMD while true; do sleep 1; done
