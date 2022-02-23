#!/usr/bin/env bash
#
# Created by Sam Lau on 2022/02/23
# Copyright © 2022 Sam Lau. All rights reserved.

set -ueo pipefail
#set -x

# Replace github url
git config --global url."https://gitclone.com/github.com".insteadOf https://github.com

# oh my zsh
if [[ ! -e ~/.oh-my-zsh ]]; then
    if [[ -x "$(command -v curl)" ]]; then
        sh -c "$(curl -fsSL https://raw.staticdn.net/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    elif [[ -x "$(command -v wget)" ]]; then
        sh -c "$(wget https://raw.staticdn.net/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    else
        echo "Please install curl or wget !"
        exit 1
    fi
fi

# zsh-autosuggestions
if [[ ! -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi