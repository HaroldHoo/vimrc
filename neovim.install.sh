#!/bin/bash
##############################################
# filename: install.sh
# author: Harold
# mail: mail@yaolong.me
# date: 2017-10-27
##############################################

type php >/dev/null 2>&1 || (echo "command not found: php"; exit 1;)
type composer >/dev/null 2>&1 || (echo "command not found: composer"; exit 1;)
type python3 >/dev/null 2>&1 || (echo "command not found: python3"; exit 1;)
type pip3 >/dev/null 2>&1 || (echo "command not found: pip"; exit 1;)
type go >/dev/null 2>&1 || (echo "command not found: go"; exit 1;)
type gocode >/dev/null 2>&1 || (echo "command not found: gocode"; exit 1;)

if [ -z "$(php -v | grep 'PHP 7')" ]; then
    echo "php version can not < 7"; exit 1;
fi

if [ -z "$(php -m | grep xml)" ]; then
    echo "please install php-ext xml"; exit 1;
fi

if [ -z "$(php -m | grep zip)" ]; then
    echo "please install php-ext zip"; exit 1;
fi

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
        nvim +PlugInstall +UpdateRemotePlugins +qa && \
            cd ~/.config/nvim/plugged/LanguageServer-php-neovim && \
            composer require felixfbecker/language-server && \
            composer install && composer run-script parse-stubs --working-dir=vendor/felixfbecker/language-server
        ;;

    [nN][oO]|[nN])
        exit 1;
        ;;

    *)
        nvim +PlugInstall +UpdateRemotePlugins +qa && \
            cd ~/.config/nvim/plugged/LanguageServer-php-neovim && \
            composer require felixfbecker/language-server && \
            composer install && composer run-script parse-stubs --working-dir=vendor/felixfbecker/language-server
        ;;
esac

