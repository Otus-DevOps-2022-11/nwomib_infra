#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y git mc
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
