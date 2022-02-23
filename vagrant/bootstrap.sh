#!/usr/bin/env bash
#
# Created by Sam Lau on 2021/12/16
# Copyright © 2021 Sam Lau. All rights reserved.

# Replace github url
git config --global url."https://hub.fastgit.org".insteadOf https://github.com

# Change ubuntu software sources
wget https://raw.githubusercontent.com/samlaudev/.dotfiles/main/vagrant/sources.list -O /etc/apt/sources.list 

# Update system software
apt-get update && apt-get -y upgrade

# Setup development environment
sh -c "$(wget https://raw.githubusercontent.com/samlaudev/.dotfiles/main/setup.sh -O -)"

apt-get install -y fzf fd-find ripgrep

