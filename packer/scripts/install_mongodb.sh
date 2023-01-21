#!/bin/sh
sudo apt-get update
sleep 10
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add - # После пайпа sudo не убрано - а то не отработает добавление ключа
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod