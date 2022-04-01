#!/usr/bin/env bash
#
# Created by Sam Lau on 2022/04/01
# Copyright © 2022 Sam Lau. All rights reserved.

# Update system software
apt-get update && apt-get -y upgrade

# Install development software
apt-get install -y zsh fzf fd-find ripgrep tldr "linux-tools-$(uname -r)" iotop iftop gdb 

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