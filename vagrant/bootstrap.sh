#!/usr/bin/env bash
#
# Created by Sam Lau on 2021/12/16
# Copyright © 2021 Sam Lau. All rights reserved.

set -x

# Change ubuntu software sources
wget https://raw.staticdn.net/samlaudev/.dotfiles/main/vagrant/sources.list -O /etc/apt/sources.list 

# Update system software
apt-get -y -qq update > /dev/null
apt-get -y -qq upgrade > /dev/null

# Install development software
apt-get install -y -qq zsh fzf fd-find ripgrep tldr "linux-tools-$(uname -r)" iotop iftop gdb python3-venv > /dev/null

# Install docker
if [[ ! -e "get-dcoker.sh" ]]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
fi

if [[ ! -x $(command -v docker) ]]; then
    sh get-docker.sh 
fi

# Change docker image source to speed up
if [[ ! -e /etc/docker ]]; then
    mkdir -p /etc/docker
fi

wget https://raw.staticdn.net/samlaudev/.dotfiles/main/vagrant/daemon.json -O /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker

# Set timezone and environment
timedatectl set-timezone Asia/Shanghai

if ! grep -qF "LANGUAGE=" /etc/environment; then
    {
        echo "LANGUAGE=en_US.UTF-8"
        echo "LC_ALL=en_US.UTF-8"
        echo "LANG=en_US.UTF-8"
        echo "LC_CTYPE=en_US.UTF-8"
    } >> /etc/environment
fi
