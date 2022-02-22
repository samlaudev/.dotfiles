#!/usr/bin/env bash 
# Created by Sam Lau on 2022/02/17 
# Copyright © 2022 Sam Lau. All rights reserved.  

# 1. Install alacritty terminal emulator 
# 2. ./setup.sh

set -ueo pipefail
# set -x

function install_tool () {
    if [[ $(uname) == Darwin && ! -x "/usr/local/bin/$1" ]]; then
        brew install "$1"    
    fi

    if [[ $(uname) == Linux && ! -x "/usr/bin/$1" ]]; then
        sudo -y apt-get install "$1" 
    fi 
}

function download_tmux_plugins () {
    git clone https://github.com/tmux-plugins/"$1" "$HOME"/.tmux/plugins/"$1"
}


# homebrew
if [[ $(uname) == Darwin && ! -x /usr/local/bin/brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# zsh
install_tool "zsh"

# oh my zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
    if [[ -x /usr/bin/curl ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    elif [[ -x /usr/bin/wget ]]; then
        sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    else
        echo "Please install curl or wget !"
        exit 1
    fi
fi

# powerlevel10k
if [[ ! -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
    git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
fi

# zsh-autosuggestions
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
   git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions 
fi

# tmux
install_tool "tmux"

# oh my tmux
if [[ ! -d "$HOME"/.tmux ]]; then
    git clone https://github.com/gpakosz/.tmux.git "$HOME"/.tmux
    ln -sf "$HOME"/.tmux/.tmux.conf "$HOME"/.tmux.conf
    
    download_tmux_plugins "tpm"
fi

# Download dotfiles and make symbol links
install_tool "stow"

if [[ ! -d $HOME/.dotfiles ]]; then
    git clone https://github.com/samlaudev/.dotfiles.git
fi

cd "$HOME/.dotfiles" 
echo "alacritty zsh powerlevel10k env aliases vim git tmux" | xargs stow

# Remind user download Meslo Nerd Font and config powerlevel10k style
echo "Please go to https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k download Meslo Nerd Font."
echo "After download Meslo Nerd Font, please run 'p10k configure' config powerlevel10k style. "
