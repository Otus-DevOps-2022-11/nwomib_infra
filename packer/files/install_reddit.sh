#!/bin/sh
sudo apt-get update
sudo apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git

touch /etc/systemd/system/puma.service
sudo chmod 664 /etc/systemd/system/puma.service
echo -e "[Unit]\nDescription=puma\n[Service]\nType=oneshot ExecStart=cd -c '/home/ubuntu/reddit && bundle install && puma -d'\nExecStop=\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/puma.service


sudo update-rc.d puma enable	