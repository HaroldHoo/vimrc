#!/bin/bash
##############################################
# filename: install.sh
# author: Harold
# mail: mail@yaolong.net
# date: 2017-08-18
##############################################
printf "\033[33mCloning Vundle...\033[0m\n"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim >/dev/null 2>&1
printf "\033[33mDownloading color molokai...\033[0m\n"
mkdir -p ~/.vim/colors && curl -sSL 'https://raw.gitmirror.com/tomasr/molokai/master/colors/molokai.vim' -o ~/.vim/colors/molokai.vim
printf "\033[33mDownloading .vimrc...\033[0m\n"
curl -ksSL 'https://raw.gitmirror.com/HaroldHoo/vimrc/master/vimrc' -o ~/.vimrc

printf "\n"
read -r -p "Press [y] to install plugins for vim. Or [n] to run [vim +PluginInstall] by yourself. [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
        vim +PluginInstall
        ;;

    [nN][oO]|[nN])
        exit 1;
        ;;

    *)
        vim +PluginInstall
        ;;
esac
