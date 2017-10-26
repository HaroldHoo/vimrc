#!/bin/bash
##############################################
# filename: install.sh
# author: Harold
# mail: mail@yaolong.me
# date: 2017-10-26
##############################################

printf "\033[33mGet Plug...\033[0m\n"
mkdir -p ~/.config/nvim/autoload && wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.config/nvim/autoload/plug.vim
printf "\033[33mDownloading color molokai...\033[0m\n"
mkdir -p ~/.config/nvim/colors && curl -sSL 'https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim' -o ~/.config/nvim/colors/molokai.vim
printf "\033[33mDownloading .vimrc...\033[0m\n"
curl -sSL 'https://raw.githubusercontent.com/HaroldHoo/vimrc/master/neovim.init.vim' -o ~/.config/nvim/init.vim

sudo pip3 install --upgrade neovim
sudo pip3 install --upgrade typing

printf "\n"
read -r -p "Press [y] to install plugins for vim. Or [n] to run [vim +PluginInstall] by yourself. [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
	nvim +PlugInstall +UpdateRemotePlugins +qa
        ;;

    [nN][oO]|[nN])
        exit 1;
        ;;

    *)
	nvim +PlugInstall +UpdateRemotePlugins +qa
        ;;
esac
