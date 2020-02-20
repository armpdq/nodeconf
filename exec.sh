#!/bin/bash
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
wget https://raw.githubusercontent.com/RusselGrace/nodeconf/master/node.conf -O /etc/nginx/conf.d/node.conf
apt-get install iptables-persistent -y 
iptables -I INPUT -p tcp -s 0.0.0.0/0 --dport 88 -j ACCEPT
invoke-rc.d iptables-persistent save
service nginx restart
mkdir /root/checkmailapi
cd /root/checkmailapi
wget https://raw.githubusercontent.com/RusselGrace/nodeconf/master/index.js -O /root/checkmailapi/index.js
wget https://raw.githubusercontent.com/RusselGrace/nodeconf/master/package.json -O /root/checkmailapi/package.json
npm install
npm install -g forever
wget https://raw.githubusercontent.com/RusselGrace/nodeconf/master/zb-mail-verif.js -O /root/checkmailapi/node_modules/zb-email-verifier/index.js
systemctl disable ufw apparmor
systemctl stop ufw apparmor

echo "@reboot /usr/sbin/ufw disable" > /root/cron
echo "@reboot cd /root/checkmailapi && forever start app.js" >> /root/cron
crontab /root/cron
