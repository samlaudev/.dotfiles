#!/usr/bin/env bash
#
# Created by Sam Lau on 2021/12/16
# Copyright © 2021 Sam Lau. All rights reserved.

# Change ubuntu software sources
wget https://raw.staticdn.net/samlaudev/.dotfiles/main/vagrant/sources.list -O /etc/apt/sources.list 

# Update system software
apt-get update && apt-get -y upgrade

# Install development software
apt-get install -y zsh fzf fd-find ripgrep