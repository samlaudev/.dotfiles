#!/usr/bin/env bash 
# Created by Sam Lau on 2022/02/17 
# Copyright © 2022 Sam Lau. All rights reserved.  

# 1. Install alacritty terminal emulator 
# 2. ./setup.sh

set -ueo pipefail
set -x

install_tool() {
    if [[ ! -x "$(command -v "$1")" ]]; then
        brew install "$1"    
    fi
}

download_tmux_plugins() {
    git clone https://github.com/tmux-plugins/"$1" "$HOME"/.tmux/plugins/"$1"
}

remove_original_dotfile() {
    if [[ ! -h "$HOME/$1" ]]; then
        rm -rf "${HOME:?}/$1"
    fi
}

log_message() {
    green="\x1b[32;21m"
    yellow="\x1b[33;21m"
    red="\x1b[31;21m"
    reset="\x1b[0m"

   case "${1}" in
       info)
           echo -e "$green$2$reset"
       ;;
       warning)
           echo -e "$yellow$2$reset"
       ;;
       error)
           echo -e "$red$2$reset"
       ;;
       *)
           echo "$1"
       ;;
   esac
}

# homebrew
if [[ ! -x "$(command -v brew)" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# zsh
install_tool "zsh"

# oh my zsh
if [[ ! -e ~/.oh-my-zsh ]]; then
    if [[ -x "$(command -v curl)" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    elif [[ -x "$(command -v wget)" ]]; then
        sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    else
        echo "Please install curl or wget !"
        exit 1
    fi
fi

# powerlevel10k
if [[ ! -e ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
    git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
fi

# zsh-autosuggestions
if [[ ! -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -e ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode ]]; then
   git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
fi

# tmux
install_tool "tmux"

# oh my tmux
if [[ ! -e "$HOME"/.tmux ]]; then
    git clone https://github.com/gpakosz/.tmux.git "$HOME"/.tmux
    ln -sf "$HOME"/.tmux/.tmux.conf "$HOME"/.tmux.conf
    
    download_tmux_plugins "tpm"
fi

# Download dotfiles and make symbol links
install_tool "stow"

if [[ ! -e $HOME/.dotfiles ]]; then
    git clone https://github.com/samlaudev/.dotfiles.git
fi

# Remove original dotfiles before make symbol links
exist_dotfiles=('.alacritty.yml' '.aliases' '.env' '.gitconfig' '.gitignore_global' '.stCommitMsg' '.p10k.zsh' '.ssh' '.tmux.conf.local' '.vimrc' '.zshrc' '.myclirc')
for item in "${exist_dotfiles[@]}"; do
    remove_original_dotfile "${item}"
done

cd "$HOME/.dotfiles" || return 
echo "alacritty zsh powerlevel10k env aliases vim git tmux ssh mycli" | xargs stow

# Install common tools
for item in {"tldr","exa","fzf","fd","bat","jq","fx","rg","lazygit","pyenv","rbenv","ruby-build"}; do
    install_tool "${item}"
done

# Remind user download Meslo Nerd Font and config powerlevel10k style
log_message info "Please go to https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k download Meslo Nerd Font."
log_message info "After download Meslo Nerd Font, please run 'p10k configure' config powerlevel10k style. "
