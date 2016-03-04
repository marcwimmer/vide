#!/bin/bash
echo 'for d in $(ls /home/odoo/.vim/bundle); do cd /home/odoo/.vim/bundle/$d; git pull; pwd; git submodule update --init --recursive; chown odoo:odoo . -R; done' > /etc/cron.hourly/update_vimbundles
echo 'cd /home/odoo/.vim/UltiSnips; git add .; git commit -am autocommit; git pull; git push; chown odoo:odoo . -R; ' > /etc/cron.hourly/update_ultisnipts
echo "apt-get update; apt-get upgrade -y" > /etc/cron.hourly/apt_upgrade
chmod a+x /etc/cron.hourly/*

