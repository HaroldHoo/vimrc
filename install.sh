#!/bin/bash
##############################################
# filename: install.sh
# author: huyaolong
# mail: huyaolong@yongche.com
# date: 2017-08-02
##############################################

echo -e "\033[33mCloning Vundle...\033[0m"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo -e "\033[33mDownloading color molokai...\033[0m"
mkdir -p ~/.vim/colors && curl -sSL 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim' -o ~/.vim/colors/molokai.vim
echo -e "\033[33mDownloading .vimrc...\033[0m"
curl -sSL 'https://raw.githubusercontent.com/HaroldHoo/vimrc/master/vimrc' -o ~/.vimrc
bash -c 'read -p "Press Enter to install plugins for vim. [Enter] to continue or [Ctrl+c] to cancel."'
vim +PluginInstall
