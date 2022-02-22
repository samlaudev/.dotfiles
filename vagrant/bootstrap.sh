#!/usr/bin/env bash
#
# Created by Sam Lau on 2021/12/16
# Copyright © 2021 Sam Lau. All rights reserved.

# replace github url
git config --global url."https://hub.fastgit.org".insteadOf https://github.com

# change ubuntu software source

apt-get update && apt-get -y upgrade
apt-get install -y apache2 zsh fzf fd-find ripgrep

if ! [[ -L /var/www ]]; then
    rm -rf /var/www
    ln -fs /vagrant /var/www
fi
