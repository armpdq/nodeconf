#!/bin/bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
wget https://raw.githubusercontent.com/RusselGrace/nodeconf/master/node.conf -O /etc/nginx/conf.d/node.conf
apt-get install iptables-persistent -y 
iptables -I INPUT -p tcp -s 0.0.0.0/0 --dport 88 -j ACCEPT
invoke-rc.d iptables-persistent save
service nginx restart
